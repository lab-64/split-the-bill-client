import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => onPressed(),
      backgroundColor: Colors.blue.shade400,
      shape: const CircleBorder(),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
