import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/presentation/shared/components/ellipse_text.dart';

class EllipseHeadline extends StatelessWidget {
  const EllipseHeadline({super.key, required this.title, required this.size});

  final String title;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Sizes.p8),
      child: EllipseText(
          text: title,
          size: size,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
