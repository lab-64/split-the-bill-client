import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';
import 'package:split_the_bill/presentation/groups/groups/join_group_dialog.dart';
import 'package:split_the_bill/presentation/shared/components/primary_button.dart';
import 'package:split_the_bill/presentation/shared/groups/groups_list.dart';
import 'package:split_the_bill/router/routes.dart';

class GroupsScreen extends ConsumerWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Groups"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
        child: Column(
          children: [
            gapH16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrimaryButton(
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (BuildContext context) => const JoinGroupDialog(),
                  ),
                  icon: Icons.arrow_forward,
                  backgroundColor: Colors.purple.shade300,
                  text: "Join Group",
                ),
                PrimaryButton(
                  onPressed: () =>
                      const EditGroupRoute(groupId: '0').push(context),
                  icon: Icons.add,
                  backgroundColor: Colors.green.shade300,
                  text: "Add Group",
                ),
              ],
            ),
            gapH16,
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref.refresh(groupsStateProvider.future),
                child: CustomScrollView(
                  slivers: [
                    GroupsList(scrollController: scrollController),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';
import 'package:split_the_bill/presentation/groups/groups/join_group_dialog.dart';
import 'package:split_the_bill/presentation/shared/components/primary_button.dart';
import 'package:split_the_bill/presentation/shared/groups/groups_list.dart';
import 'package:split_the_bill/router/routes.dart';

class GroupsScreen extends ConsumerWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Groups"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
        child: Column(
          children: [
            RefreshIndicator(
              onRefresh: () => ref.refresh(groupsStateProvider.future),
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: gapH16),
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryButton(
                          onPressed: () => showDialog<void>(
                            context: context,
                            builder: (BuildContext context) =>
                                const JoinGroupDialog(),
                          ),
                          icon: Icons.arrow_forward,
                          backgroundColor: Colors.purple.shade300,
                          text: "Join Group",
                        ),
                        PrimaryButton(
                          onPressed: () =>
                              const EditGroupRoute(groupId: '0').push(context),
                          icon: Icons.add,
                          backgroundColor: Colors.green.shade300,
                          text: "Add Group",
                        ),
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(child: gapH16),
                  GroupsList(scrollController: scrollController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 */
