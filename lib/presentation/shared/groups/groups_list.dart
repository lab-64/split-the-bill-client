import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/placeholder_display.dart';
import 'package:split_the_bill/router/routes.dart';

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
        child: _buildGroupsListView(context, groups),
      ),
    );
  }

  Widget _buildGroupsListView(BuildContext context, List<Group> groups) {
    if (groups.isEmpty) {
      return const PlaceholderDisplay(
        icon: Icons.groups,
        message: "No groups",
      );
    }

    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return _buildGroupTile(context, group);
      },
    );
  }

  Widget _buildGroupTile(BuildContext context, Group group) {
    return GroupTile(
      group: group,
      onTap: () => GroupRoute(groupId: group.id).push(context),
    );
  }
}
