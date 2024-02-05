import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/domain/group/group.dart';
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
        child: _buildGroupsListView(context, groups),
      ),
    );
  }

  Widget _buildGroupsListView(BuildContext context, List<Group> groups) {
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
      onTap: () => _onTap(context, group),
    );
  }

  void _onTap(BuildContext context, Group group) {
    context.goNamed(
      GoRouterState.of(context).name == NavbarRoutes.home.name
          ? Routes.homeGroup.name
          : Routes.group.name,
      pathParameters: {'groupId': group.id},
    );
  }
}
