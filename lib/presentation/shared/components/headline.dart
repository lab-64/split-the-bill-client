import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/app_sizes.dart';

class Headline extends StatelessWidget {
  const Headline({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Sizes.p8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
