import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.isLoading = false,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    VoidCallback? onPressedAction;
    if (isLoading) {
      onPressedAction = null;
    } else {
      onPressedAction = onPressed;
    }

    return FloatingActionButton(
      onPressed: onPressedAction,
      backgroundColor: isLoading ? Colors.grey : Colors.blue[400],
      shape: const CircleBorder(),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
