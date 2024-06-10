import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceTextField extends StatelessWidget {
  const PriceTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.onChanged,
    this.fillColor = Colors.white,
  });

  final TextEditingController controller;
  final String labelText;
  final Icon prefixIcon;
  final Function(String) onChanged;
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
        FilteringTextInputFormatter.allow(RegExp(r'^-?[0-9.]*-?$')),
      ],
      controller: controller,
      onChanged: (value) {
        if (value.isEmpty) {
          onChanged(value);
          return;
        }

        //push '-' to the front
        if (value.endsWith('-')) {
          controller.text = "-${value.substring(0, value.length - 1)}";
          return;
        }

        if (value.endsWith('.')) {
          controller.text = value.substring(0, value.length - 1);
          return;
        }

        //cut out negative sign for processing
        final isNegative = value.startsWith('-');
        if (isNegative) {
          value = value.substring(1);
        }

        var index = value.indexOf('.');
        //replace ','
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
          String text = value.length == 2 ? '0.$value' : '0.0$value';
          if (isNegative) {
            text = "-$text";
          }
          controller.text = text;
        } else if (value.length >= 3) {
          //at least 1
          String text =
              '${value.substring(0, value.length - 2)}.${value.substring(value.length - 2)}';
          if (isNegative) {
            text = "-$text";
          }
          controller.text = text;
        }

        onChanged(controller.text);
      },
    );
  }
}
