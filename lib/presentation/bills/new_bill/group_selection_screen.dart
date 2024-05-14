import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/headline.dart';
import 'package:split_the_bill/presentation/shared/groups/group_tile.dart';
import 'package:split_the_bill/router/routes.dart';

class GroupSelectionScreen extends ConsumerWidget {
  GroupSelectionScreen({super.key});
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(groupsStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Bill"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gapH16,
            const Headline(title: "Select a group"),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  AsyncValueSliverWidget(
                    value: groups,
                    data: (groups) => SliverToBoxAdapter(
                      child: _buildGroupsListView(context, groups),
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
      onTap: () => NewBillRoute(groupId: group.id).push(context),
      isDetailed: false,
    );
  }
}
