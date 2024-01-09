import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ItemContainer extends StatelessWidget {
  const ItemContainer({
    super.key,
    required this.name,
    required this.price,
    required this.index,
    required this.deleteSelf,
    required this.onChanged,
  });

  final TextEditingController name;
  final TextEditingController price;
  final int index;
  final Function deleteSelf;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: TextField(
            style: const TextStyle(color: Colors.black),
            controller: name,
            onChanged: (name) => {onChanged(name, true, index)},
            decoration: const InputDecoration(
              labelText: "Name",
              isDense: true,
              prefixIcon: Icon(Icons.drive_file_rename_outline),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: TextField(
            style: const TextStyle(color: Colors.black),
            controller: price,
            onChanged: (price) => {onChanged(price, false, index)},
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.attach_money,
              ),
              isDense: true,
              labelText: "Price",
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: IconButton(
            onPressed: () => {deleteSelf(index)},
            icon: const Icon(Icons.delete),
            color: Colors.red,
          ),
        )
      ],
    );
  }
}
