import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/bill_suggestion.dart';
import 'package:split_the_bill/presentation/bills/new_bill/controllers.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';
import 'package:split_the_bill/presentation/shared/components/headline.dart';

class ItemsCheckDialog extends ConsumerStatefulWidget {
  const ItemsCheckDialog({super.key, required this.billId});

  final String billId;

  @override
  ConsumerState<ItemsCheckDialog> createState() => _ItemsCheckDialogState();
}

class _ItemsCheckDialogState extends ConsumerState<ItemsCheckDialog> {
  final List<BillSuggestion> _history = [];
  int _currentHistoryIndex = 0;
  List<String> _currentNameList = [];
  List<double> _currentPriceList = [];
  late LinkedScrollControllerGroup _controllers;
  late ScrollController _scrollControllerName;
  late ScrollController _scrollControllerPrice;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    final billRecognition = await ref.read(billRecognitionProvider.future);
    _history.add(billRecognition);
    _currentNameList = List.from(billRecognition.nameList);
    _currentPriceList = List.from(billRecognition.priceList);

    _controllers = LinkedScrollControllerGroup();
    _scrollControllerName = _controllers.addAndGet();
    _scrollControllerPrice = _controllers.addAndGet();

  }

  void _confirm(BuildContext context, WidgetRef ref) {
    final billSuggestion = _history[_currentHistoryIndex];

    // TODO: show a snackbar or dont allow to remove all elements
    if (billSuggestion.nameList.every((element) => element.isEmpty) &&
        billSuggestion.priceList.every((element) => element == 0)) {
      return;
    }

    ref
        .read(itemsProvider(widget.billId).notifier)
        .setItemsFromSuggestion(_history[_currentHistoryIndex]);
    Navigator.pop(context);
  }

  /// Removes the name at the specified [index] from the current name list,
  /// adds an empty string in its place, and updates the history accordingly.
  void _onNameDeletePressed(int index) {
    _currentNameList.removeAt(index);

    _history.add(_history.last.copyWith(
      nameList: List.from(_currentNameList),
    ));
    _currentHistoryIndex++;
  }

  /// Removes the price at the specified [index] from the current price list,
  /// adds 0 in its place, and updates the history accordingly.
  void _onPriceDeletePressed(int index) {
    _currentPriceList.removeAt(index);

    _history.add(_history.last.copyWith(
      priceList: List.from(_currentPriceList),
    ));
    _currentHistoryIndex++;
  }

  /// Reverts the state of the both lists to the previous state and updates the history accordingly.
  void _onUndoPressed() {
    setState(() {
      _currentHistoryIndex--;
      final billSuggestion = _history[_currentHistoryIndex];
      _history.removeLast();
      _currentNameList = List.from(billSuggestion.nameList);
      _currentPriceList = List.from(billSuggestion.priceList);

      if (_currentHistoryIndex == 0) {
        _history.clear();
        _history.add(billSuggestion);
      }
    });
  }

  void _addEmptyName() {
    _currentNameList.insert(0, '');

    _history.add(_history.last.copyWith(
      nameList: List.from(_currentNameList),
    ));
    _currentHistoryIndex++;
  }

  void _addEmptyPrice() {
    _currentPriceList.insert(0, 0);

    _history.add(_history.last.copyWith(
      priceList: List.from(_currentPriceList),
    ));
    _currentHistoryIndex++;
  }

  @override
  Widget build(BuildContext context) {
    final billRecognition = ref.watch(billRecognitionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Items'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (_currentHistoryIndex > 0)
            IconButton(
              icon: const Icon(Icons.undo),
              onPressed: () {
                setState(() => _onUndoPressed());
              },
            ),
        ],
      ),
      floatingActionButton: ActionButton(
        onPressed: () => _confirm(context, ref),
        icon: Icons.check,
      ),
      body: AsyncValueWidget(
        value: billRecognition,
        data: (billSuggestion) {
          return Column(
            children: [
              const ItemsCheckDialogHeader(),
              const Divider(
                height: 0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () => setState(() {
                            _addEmptyName();
                          }),
                      icon: const Icon(Icons.add_box_outlined)),
                  IconButton(
                      onPressed: () => setState(() {
                            _addEmptyPrice();
                          }),
                      icon: const Icon(Icons.add_box_outlined))
                ],
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollControllerName,
                        itemCount: _currentNameList.length,
                        itemBuilder: (context, index) {
                          if (_currentNameList[index].isNotEmpty) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.p24, vertical: Sizes.p8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          if (_currentNameList[index]
                                              .isNotEmpty)
                                            IconButton(
                                              icon: const Icon(Icons.close),
                                              onPressed: () {
                                                setState(() =>
                                                    _onNameDeletePressed(
                                                        index));
                                              },
                                            ),
                                          Expanded(
                                            child: Text(
                                              _currentNameList[index],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return null;
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollControllerPrice,
                        itemCount: _currentPriceList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Sizes.p24, vertical: Sizes.p8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            setState(() =>
                                                _onPriceDeletePressed(index));
                                          },
                                        ),
                                        Expanded(
                                          child: Text(
                                            _currentPriceList[index].toString(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ItemsCheckDialogHeader extends StatelessWidget {
  const ItemsCheckDialogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:
          EdgeInsets.only(left: Sizes.p24, right: Sizes.p24, top: Sizes.p16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Headline(
            title: 'Name',
          ),
          Headline(
            title: 'Price',
          ),
        ],
      ),
    );
  }
}

void showItemsCheckDialog(BuildContext context, String billId) {
  Navigator.pop(context);
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (BuildContext context) {
        return ItemsCheckDialog(billId: billId);
      },
    ),
  );
}
