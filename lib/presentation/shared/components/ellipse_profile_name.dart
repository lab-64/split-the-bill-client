import 'package:flutter/material.dart';

class EllipseProfileName extends StatelessWidget {
  const EllipseProfileName(
      {super.key, required this.name, required this.size, required this.style});

  final String name;
  final double size;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: Text(name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: style),
    );
  }
}
