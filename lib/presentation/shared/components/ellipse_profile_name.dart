import 'package:flutter/material.dart';

class EllipseProfileName extends StatefulWidget {
  const EllipseProfileName(
      {super.key, required this.name, required this.size, required this.style});

  final String name;
  final double size;
  final TextStyle style;

  @override
  State<EllipseProfileName> createState() => _EllipseProfileNameState();
}

class _EllipseProfileNameState extends State<EllipseProfileName> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      child: Text(widget.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: widget.style),
    );
  }
}
