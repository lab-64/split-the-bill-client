import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/app_sizes.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key, required this.text, this.isLoading = false, this.onPressed});
  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.p48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        onPressed: onPressed,
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              ),
      ),
    );
  }
}
