import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:split_the_bill/providers/dummy_data_calls.dart';
import 'package:split_the_bill/widgets/screen_title.dart';

import '../../models/item.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key, required this.dummyCalls, required this.itemId})
      : super(key: key);
  final DummyDataCalls dummyCalls;
  final int itemId;

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  late Item item = widget.dummyCalls.getItem(widget.itemId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ScreenTitle(text: "Add Item Page"),
            ItemFormFields(
              item: item,
            ),
            FloatingActionButton(
              heroTag: "SaveAndExit",
              onPressed: () => {saveItemAndExit()},
              child: const Icon(Icons.check),
            ),
            FloatingActionButton(
              heroTag: "DeleteAndExit",
              onPressed: () => {saveItemAndExit(delete: true)},
              child: const Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }

  saveItemAndExit({bool delete = false}) {
    if (delete) {
      if (item.id < 0) {
        Navigator.pop(context);
      } else {
        Navigator.pop(context, item.id);
      }
    } else {
      if (item.id < 0) {
        Navigator.pop(context, item);
      } else {
        widget.dummyCalls.overwriteItem(item);
        Navigator.pop(context);
      }
    }
  }
}

class ItemFormFields extends StatelessWidget {
  const ItemFormFields({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Name:"),
            SizedBox(
              width: 200,
              child: TextFormField(
                initialValue: item.name,
                onChanged: (billName) => {item.name = billName},
                decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.blue),
                  hintText: item.name,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Price:"),
            SizedBox(
              width: 50,
              child: TextFormField(
                initialValue: item.price.toString(),
                onChanged: (value) => {
                  if (double.tryParse(value) != null)
                    item.price = double.parse(value)
                },
                decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.blue),
                    hintText: item.price.toString(),
                    border: const OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: true),
                inputFormatters: [
                  //int, double and float allowed
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
