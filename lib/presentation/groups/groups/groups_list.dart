import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/routes.dart';

import 'group_tile.dart';

class GroupsList extends ConsumerWidget {
  const GroupsList({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(groupsStateProvider);

    return AsyncValueSliverWidget(
      value: groups,
      data: (groups) => SliverToBoxAdapter(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: Sizes.p8),
              child: ListView(
                controller: scrollController,
                shrinkWrap: true,
                children: [
                  for (final group in groups)
                    GroupTile(
                      group: group,
                      onPressed: () => context.goNamed(
                        Routes.group.name,
                        pathParameters: {'id': group.id},
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
