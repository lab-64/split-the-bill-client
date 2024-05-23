import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/ui_constants.dart';

Future<void> showBottomModal(
  BuildContext context,
  String title,
  Widget body,
) async {
  return await showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Sizes.p12),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                ),
              ],
            ),
            body,
          ],
        ),
      );
    },
  );
}
