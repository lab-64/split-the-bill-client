import 'package:flutter/material.dart';

class TutorialHelpButton extends StatelessWidget {
  final VoidCallback onPressed;

  const TutorialHelpButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.help_outline),
      tooltip: 'Show Help',
      onPressed: onPressed,
    );
  }
}
