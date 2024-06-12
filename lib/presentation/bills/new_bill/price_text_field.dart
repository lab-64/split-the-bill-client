import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceTextField extends StatelessWidget {
  const PriceTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.fillColor = Colors.white,
  });

  final TextEditingController controller;
  final String labelText;
  final Icon prefixIcon;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        fillColor: fillColor,
        filled: true,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
      ],
      controller: controller,
      onChanged: (value) {
        //replace ','
        var index = value.indexOf('.');
        if (value.endsWith('.')) {
          controller.text = value.substring(0, value.length - 1);
          return;
        }
        value = value.substring(0, index) +
            value.substring(index + 1, value.length);

        //push numbers to the right if a number is deleted
        if (value.length < 3) {
          var first = value.substring(0, 1);
          var second = value.substring(1, 2);
          controller.text = '0.$first$second';
          return;
        }

        //remove leading zeros
        while (value[0] == '0') {
          value = value.substring(1);
        }

        if (value.length < 3) {
          //less than 1
          controller.text = value.length == 2 ? '0.$value' : '0.0$value';
        } else if (value.length >= 3) {
          //at least 1
          controller.text =
              '${value.substring(0, value.length - 2)}.${value.substring(value.length - 2)}';
        }

        //onChanged(controller.text);
      },
    );
  }
}
