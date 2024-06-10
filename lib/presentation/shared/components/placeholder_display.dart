import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/ui_constants.dart';

class PlaceholderDisplay extends StatelessWidget {
  final IconData icon;
  final String message;

  const PlaceholderDisplay({
    super.key,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 80,
          color: Colors.grey,
        ),
        gapH4,
        Text(
          message,
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }
}
