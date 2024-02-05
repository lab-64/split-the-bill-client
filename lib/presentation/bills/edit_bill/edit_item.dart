import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/item.dart';

class EditItem extends StatefulWidget {
  const EditItem({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onChanged,
  });

  final Item item;
  final VoidCallback onDelete;
  final Function(String, String) onChanged;

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  late TextEditingController nameController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.item.name);
    priceController = TextEditingController(text: widget.item.price.toString());
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            style: const TextStyle(color: Colors.black),
            controller: nameController,
            onChanged: (name) => widget.onChanged(name, priceController.text),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.p24),
              ),
              labelText: "Name",
              fillColor: Colors.white,
              filled: true,
              prefixIcon: Icon(Icons.drive_file_rename_outline),
            ),
          ),
        ),
        gapW12,
        Expanded(
          child: TextField(
            style: const TextStyle(color: Colors.black),
            controller: priceController,
            onChanged: (price) => widget.onChanged(nameController.text, price),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.p24),
              ),
              labelText: "Price",
              fillColor: Colors.white,
              filled: true,
              prefixIcon: Icon(Icons.attach_money),
            ),
          ),
        ),
        IconButton(
          onPressed: widget.onDelete,
          icon: const Icon(Icons.delete),
          color: Colors.red,
        ),
      ],
    );
  }
}
