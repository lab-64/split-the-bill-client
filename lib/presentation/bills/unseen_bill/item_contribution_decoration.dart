import 'package:flutter/material.dart';

class ItemContributionDecoration extends StatelessWidget {
  const ItemContributionDecoration({super.key, required this.child, required this.borderColor});

  final Widget child;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: borderColor, width: 1),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(padding: const EdgeInsets.all(2.0), child: child)));
  }
}
