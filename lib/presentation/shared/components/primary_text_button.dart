import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/app_sizes.dart';

class PrimaryTextButton extends StatelessWidget {
  const PrimaryTextButton({
    super.key,
    required this.text,
    this.isLoading = false,
    this.onPressed,
  });

  final String text;
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
            : Text(text,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: Colors.white, fontSize: Sizes.p24)),
      ),
    );
  }
}
