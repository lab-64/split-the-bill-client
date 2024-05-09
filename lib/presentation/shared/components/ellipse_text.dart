import 'package:flutter/material.dart';

class EllipseText extends StatelessWidget {
  const EllipseText(
      {super.key, required this.text, required this.size, required this.style});

  final String text;
  final double size;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: Text(text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: style),
    );
  }
}
