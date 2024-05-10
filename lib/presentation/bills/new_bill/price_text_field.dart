import 'package:flutter/material.dart';

class PriceTextField extends StatefulWidget {
  const PriceTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.prefixIcon});

  final TextEditingController controller;
  final String labelText;
  final Icon prefixIcon;

  @override
  State<PriceTextField> createState() => _PriceTextFieldState();
}

class _PriceTextFieldState extends State<PriceTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.white,
        filled: true,
      ),
      keyboardType: TextInputType.number,
      controller: widget.controller,
      onChanged: (value) {
        //replace ','
        var index = value.indexOf('.');
        value = value.substring(0, index) +
            value.substring(index + 1, value.length);

        //push numbers to the right if a number is deleted
        if (value.length < 3) {
          var first  = value.substring(0,1);
          var second = value.substring(1,2);
          widget.controller.text = '0.$first$second';
          return;
        }

        //remove leading zeros
        while (value[0] == '0') {
          value = value.substring(1);
        }

        setState(() {
          if (value.length < 3) {
            //less than 1
            widget.controller.text =
                value.length == 2 ? '0.$value' : '0.0$value';
          } else if (value.length >= 3) {
            //at least 1
            widget.controller.text =
                '${value.substring(0, value.length - 2)}.${value.substring(value.length - 2)}';
          }
        });
      },
    );
  }
}
