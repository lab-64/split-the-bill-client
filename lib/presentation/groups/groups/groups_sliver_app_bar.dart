import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation/groups/groups/groups_sliver_app_bar_balance.dart';
import 'package:split_the_bill/presentation/groups/groups/groups_sliver_app_bar_greeting.dart';

class GroupSliverAppBar extends StatelessWidget {
  const GroupSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      expandedHeight: 120,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.blue[700],
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 3,
              blurRadius: 7,
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GroupSliverAppBarGreeting(),
            GroupSliverAppBarBalance(),
          ],
        ),
      ),
    );
  }
}
