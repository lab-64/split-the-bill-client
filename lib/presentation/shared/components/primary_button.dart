import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/app_sizes.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.text,
    required this.icon,
    this.isLoading = false,
    this.onPressed,
  });

  final String? text;
  final IconData icon;
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.p48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade400,
        ),
        child: isLoading
            ? const CircularProgressIndicator()
            : Icon(
                icon,
                size: Sizes.p32,
                color: Colors.white,
              ),
      ),
    );
  }
}
