import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/presentation/groups/groups/controllers.dart';

class GroupSilverAppBar extends ConsumerWidget {
  const GroupSilverAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).requireValue;
    final groupsTotalBalance = ref.watch(groupsTotalBalanceProvider);

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  "Hi",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                gapW8,
                Consumer(
                  builder: (context, ref, child) {
                    return Text(
                      user.username,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.apply(fontWeightDelta: 2, color: Colors.white),
                    );
                  },
                ),
              ],
            ),
            Column(
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
                Text(
                  "$groupsTotalBalance €",
                  style: Theme.of(context).textTheme.headlineMedium?.apply(
                        fontWeightDelta: 2,
                        color: Colors.lightGreenAccent,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
