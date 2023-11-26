import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/constants/app_sizes.dart';

class GroupSliverAppBarGreeting extends ConsumerWidget {
  const GroupSliverAppBarGreeting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).requireValue;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Text(
          "Hi",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        gapW8,
        Text(
          user.email,
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.apply(fontWeightDelta: 2, color: Colors.white),
        ),
      ],
    );
  }
}
