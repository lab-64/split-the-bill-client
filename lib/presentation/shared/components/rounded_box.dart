import 'package:flutter/material.dart';

class RoundedBox extends StatelessWidget {
  const RoundedBox(
      {super.key,
      required this.child,
      required this.firstPadding,
      required this.secondPadding, required this.backgroundColor});

  final EdgeInsetsGeometry firstPadding;
  final EdgeInsetsGeometry secondPadding;
  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: firstPadding,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: Padding(
          padding: secondPadding,
          child: child,
        ),
      ),
    );
  }
}
