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
        FilteringTextInputFormatter.allow(RegExp(r'^-?[0-9 .,]*-?$')),
      ],
      controller: controller,
      onChanged: (value) {
        if (value.isEmpty) {
          onChanged(value);
          return;
        }

        // Remove unwanted characters
        if (value.contains(",") || value.contains(" ")) {
          controller.text = value.replaceAll(',', '').replaceAll(' ', '');
          return;
        }

        // Push '-' to the front
        if (value.endsWith('-')) {
          if (value.startsWith('-')) {
            controller.text = value.substring(1, value.length - 1);
            return;
          } else {
            controller.text = "-${value.substring(0, value.length - 1)}";
            return;
          }
        }

        if (value.endsWith('.')) {
          controller.text = value.substring(0, value.length - 1);
          return;
        }

        // Cut out negative sign for processing
        final isNegative = value.startsWith('-');
        if (isNegative) {
          value = value.substring(1);
        }

        var index = value.indexOf('.');
        if (index != -1) {
          // Ensure decimal point processing does not leave unwanted characters
          value = value.substring(0, index) +
              value.substring(index + 1, value.length);
        }

        // Push numbers to the right if a number is deleted
        if (value.length < 3) {
          var first = value.substring(0, 1);
          var second = value.length > 1 ? value.substring(1, 2) : '0';
          controller.text = '0.$first$second';
          if (isNegative) {
            controller.text = '-${controller.text}';
          }
          return;
        }

        // Remove leading zeros
        while (value.isNotEmpty && value[0] == '0') {
          value = value.substring(1);
        }

        if (value.length < 3) {
          // Less than 1
          String text = value.length == 2 ? '0.$value' : '0.0$value';
          if (isNegative) {
            text = "-$text";
          }
          controller.text = text;
        } else if (value.length >= 3) {
          // At least 1
          String text =
              '${value.substring(0, value.length - 2)}.${value.substring(value.length - 2)}';
          if (isNegative) {
            text = "-$text";
          }
          controller.text = text;
        }

        // Move the cursor to the end of the text
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );

        onChanged(controller.text);
      },
    );
  }
}
