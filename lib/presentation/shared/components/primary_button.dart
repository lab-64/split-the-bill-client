import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/ui_constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    required this.backgroundColor,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final String text;
  final Color backgroundColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.p24),
        ),
      ),
      icon: Icon(icon),
      label: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.p12,
        ),
        child: Text(
          text,
          style: const TextStyle(
            letterSpacing: 1,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
