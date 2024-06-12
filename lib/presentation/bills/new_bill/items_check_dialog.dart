import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/bill_suggestion.dart';
import 'package:split_the_bill/presentation/bills/new_bill/controllers.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';
import 'package:split_the_bill/presentation/shared/extensions/currency_formatter.dart';

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

  /// Adds an empty name to the start of the list
  void _addEmptyName() {
    _currentNameList.insert(0, '');

    _history.add(_history.last.copyWith(
      nameList: List.from(_currentNameList),
    ));
    _currentHistoryIndex++;
  }

  /// Adds an price of 0 at the start of the list
  void _addEmptyPrice() {
    _currentPriceList.insert(0, 0);

    _history.add(_history.last.copyWith(
      priceList: List.from(_currentPriceList),
    ));
    _currentHistoryIndex++;
  }

  /// reorders the list, after an item is moved
  void _reorderList(int oldIndex, int newIndex, bool isName) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      if (isName) {
        final item = _currentNameList.removeAt(oldIndex);
        _currentNameList.insert(newIndex, item);

        _history.add(_history.last.copyWith(
          nameList: List.from(_currentNameList),
        ));
      } else {
        final item = _currentPriceList.removeAt(oldIndex);
        _currentPriceList.insert(newIndex, item);

        _history.add(_history.last.copyWith(
          priceList: List.from(_currentPriceList),
        ));
      }
      _currentHistoryIndex++;
    });
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Card(
                        elevation: 0,
                        color: Colors.white,
                        child: IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: const Icon(Icons.add),
                          onPressed: () => setState(() {
                            _addEmptyName();
                            _controllers.jumpTo(0);
                          }),
                        ),
                      ),
                    ),
                    gapW8,
                    Expanded(
                      flex: 1,
                      child: Card(
                        elevation: 0,
                        color: Colors.white,
                        child: IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: const Icon(Icons.add),
                          onPressed: () => setState(() {
                            _addEmptyPrice();
                            _controllers.jumpTo(0);
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.p24),
                child: Divider(),
              ),
              gapH8,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ReorderableListView.builder(
                          scrollController: _scrollControllerName,
                          itemCount: _currentNameList.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              onDismissed: (_) => setState(
                                () => _onNameDeletePressed(index),
                              ),
                              background: const Card(
                                color: Colors.red,
                                elevation: 0,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              key: Key(
                                '${_currentNameList[index]}$index${_currentNameList.length}',
                              ),
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Sizes.p8,
                                    horizontal: Sizes.p16,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _currentNameList[index],
                                          maxLines: 1,
                                        ),
                                      ),
                                      ReorderableDragStartListener(
                                        index: index,
                                        child: const Icon(Icons.drag_handle),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          onReorder: (int oldIndex, int newIndex) =>
                              _reorderList(oldIndex, newIndex, true),
                        ),
                      ),
                      gapW8,
                      Expanded(
                        flex: 1,
                        child: ReorderableListView.builder(
                          scrollController: _scrollControllerPrice,
                          itemCount: _currentPriceList.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              onDismissed: (_) => setState(
                                () => _onPriceDeletePressed(index),
                              ),
                              background: const Card(
                                color: Colors.red,
                                elevation: 0,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              key: Key(
                                '${_currentPriceList[index]}$index${_currentPriceList.length}',
                              ),
                              child: Card(
                                elevation: 0,
                                color: Colors.white,
                                key: Key('$index'),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Sizes.p8,
                                    horizontal: Sizes.p16,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _currentPriceList[index]
                                              .toCurrencyString(),
                                          maxLines: 1,
                                        ),
                                      ),
                                      ReorderableDragStartListener(
                                        index: index,
                                        child: const Icon(Icons.drag_handle),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          onReorder: (int oldIndex, int newIndex) =>
                              _reorderList(oldIndex, newIndex, false),
                        ),
                      )
                    ],
                  ),
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
      padding: EdgeInsets.only(
        left: Sizes.p24,
        right: Sizes.p24,
        top: Sizes.p16,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Icon(Icons.edit),
                gapW8,
                Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Icon(Icons.price_check),
                gapW8,
                Text(
                  'Price',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showItemsCheckDialog(BuildContext context, String billId) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (BuildContext context) {
        return ItemsCheckDialog(billId: billId);
      },
    ),
  );
}
