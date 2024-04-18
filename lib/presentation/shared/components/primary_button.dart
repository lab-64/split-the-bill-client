import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/app_sizes.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.icon,
    required this.text,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final IconData? icon;
  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green.shade400,
        textStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        minimumSize: const Size(0, Sizes.p48),
      ),
      child: isLoading
          ? const CircularProgressIndicator()
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Row(
                    children: [
                      Icon(icon, color: Colors.white),
                      gapW12,
                    ],
                  ),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
    );
  }
}
