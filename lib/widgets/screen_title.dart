import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SelectionContainer.disabled(
        child: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 40, height: 5),
    ));
  }
}
