import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
    this.onChanged,
    this.onTap,
    this.keyboardType,
    this.inputFormatters,
    this.isLoading = false,
    this.isDisabled = false,
    this.obscureText = false,
    this.readOnly = false,
    this.fillColor = Colors.white
  });

  final String labelText;
  final Icon prefixIcon;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isLoading;
  final bool isDisabled;
  final bool obscureText;
  final bool readOnly;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        enabled: !isLoading && !isDisabled,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        fillColor: fillColor,
        filled: true,
      ),
    );
  }
}
