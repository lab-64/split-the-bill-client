import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/presentation/groups/groups/controllers.dart';

class BillTile extends StatelessWidget {
  const BillTile({super.key, required this.bill, required this.showGroup});

  final Bill bill;
  final bool showGroup;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0.0, bottom: 8.0),
          child: Text(
            "18.01",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.only(bottom: Sizes.p16),
          elevation: 0.5,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
                horizontal: Sizes.p16, vertical: Sizes.p4),
            leading: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.green.shade300, Colors.green.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(
                Icons.attach_money,
                color: Colors.white,
              ),
            ),
            title: Row(
              children: [
                Text(
                  bill.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 8.0,
                      backgroundImage: AssetImage('assets/avatar.jpg'),
                    ),
                    SizedBox(width: Sizes.p4),
                    Text(
                      "Felix",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: showGroup,
                  child: Row(
                    children: [
                      Container(
                        width: 16.0,
                        height: 16.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple.shade300,
                              Colors.purple.shade700
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Icon(
                          Icons.home,
                          size: 10,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: Sizes.p4),
                      const Text(
                        "Wohnung",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "235,53 €",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: Sizes.p8),
                Icon(Icons.navigate_next),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
