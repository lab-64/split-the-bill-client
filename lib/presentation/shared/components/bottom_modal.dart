import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/ui_constants.dart';

Future<void> showBottomModal(
  BuildContext context,
  String title,
  Widget body,
) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
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
        ),
      );
    },
  );
}
