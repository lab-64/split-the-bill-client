import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.disabled = false,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => onPressed(),
      backgroundColor: disabled ? Colors.grey : Colors.blue.shade400,
      shape: const CircleBorder(),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
