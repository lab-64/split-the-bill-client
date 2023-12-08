import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/presentation/groups/groups/controllers.dart';

class GroupCard extends ConsumerWidget {
  const GroupCard({super.key, required this.group, this.onPressed});

  final Group group;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(groupBalanceProvider(group.id));

    return Card(
      color: Colors.blue,
      margin:
          const EdgeInsets.symmetric(vertical: Sizes.p8, horizontal: Sizes.p16),
      elevation: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.p24),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.p24,
            vertical: Sizes.p32,
          ),
          child: Row(
            children: <Widget>[
              const FlutterLogo(size: Sizes.p48),
              gapW16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      group.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text("$balance €",
                        style: Theme.of(context).textTheme.titleLarge?.apply(
                            color: balance >= 0
                                ? Colors.lightGreenAccent
                                : Colors.red)),
                  ],
                ),
              ),
              const Icon(
                Icons.navigate_next,
                size: Sizes.p32,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
