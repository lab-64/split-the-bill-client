import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/presentation/groups/groups/controllers.dart';

class GroupsAppBarBalance extends StatelessWidget {
  const GroupsAppBarBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text(
              "Balance",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        Consumer(
          builder: (context, ref, child) {
            return Text(
              "${ref.watch(groupsTotalBalanceProvider)} €",
              style: Theme.of(context).textTheme.headlineMedium?.apply(
                    fontWeightDelta: 2,
                    color: Colors.lightGreenAccent,
                  ),
            );
          },
        ),
      ],
    );
  }
}
