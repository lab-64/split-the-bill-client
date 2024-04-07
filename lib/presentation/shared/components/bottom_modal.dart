import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/presentation/shared/components/primary_button.dart';

Future<void> showBottomModal(BuildContext context) async {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: Sizes.p16),
                  child: Text(
                    'Edit profile picture',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => context.pop(),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                PrimaryButton(
                  onPressed: () {
                    // Handle select photo action
                  },
                  text: 'asd',
                ),
                PrimaryButton(
                  onPressed: () {
                    // Handle select photo action
                  },
                  text: 'asd',
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
