import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/presentation/bills/new_bill/controllers.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';

class ItemsCheckDialog extends ConsumerWidget {
  const ItemsCheckDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billRecognition = ref.watch(billRecognitionProvider);

    return AsyncValueWidget(
      value: billRecognition,
      data: (bill) {
        return ItemListWithDeletion(
          itemList: bill.itemList,
          priceList: bill.priceList,
        );
      },
    );
  }
}

class ItemListWithDeletion extends StatefulWidget {
  const ItemListWithDeletion({
    super.key,
    required this.itemList,
    required this.priceList,
  });

  final List<String> itemList;
  final List<double> priceList;

  @override
  _ItemListWithDeletionState createState() => _ItemListWithDeletionState();
}

class _ItemListWithDeletionState extends State<ItemListWithDeletion> {
  late List<String> _currentItemList;
  late List<double> _currentPriceList;

  @override
  void initState() {
    super.initState();
    _currentItemList = List.from(widget.itemList);
    _currentPriceList = List.from(widget.priceList);
  }

  void _deleteEntry(int index) {
    setState(() {
      _currentItemList.removeAt(index);
      _currentPriceList.removeAt(index);
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _currentItemList.removeAt(index);
    });
  }

  void _deletePrice(int index) {
    setState(() {
      _currentPriceList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        _currentItemList.length,
        (index) => Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => _deleteItem(index),
                  ),
                  Text(_currentItemList[index]),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => _deletePrice(index),
                  ),
                  Text(_currentPriceList[index].toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
