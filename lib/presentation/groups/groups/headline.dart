import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/presentation/groups/groups/add_new_group_button.dart';
import 'package:split_the_bill/presentation/groups/groups/balance_card.dart';
import 'package:split_the_bill/presentation/groups/groups/groups_list.dart';

import 'app_bar/groups_app_bar.dart';

class Headline extends StatelessWidget {
  const Headline({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Sizes.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text("See All"),
        ],
      ),
    );
  }
}
