import 'package:flutter/material.dart';

class FadeText extends StatelessWidget {
  const FadeText({
    super.key,
    required this.text,
    this.style,
  });

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.fade,
      softWrap: false,
      style: style,
    );
  }
}
