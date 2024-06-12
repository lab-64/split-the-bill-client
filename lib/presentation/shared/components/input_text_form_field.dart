import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextFormField extends StatelessWidget {
  const InputTextFormField({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.isLoading = false,
    this.isDisabled = false,
    this.obscureText = false,
    this.autofocus = false,
  });

  final String labelText;
  final Icon prefixIcon;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isLoading;
  final bool isDisabled;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      validator: validator,
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
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}
