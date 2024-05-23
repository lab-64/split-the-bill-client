import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';
import 'package:split_the_bill/presentation/groups/groups/join_group_dialog.dart';
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
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: () => showDialog<void>(
              context: context,
              builder: (BuildContext context) => const JoinGroupDialog(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => const EditGroupRoute(groupId: '0').push(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
        child: RefreshIndicator(
          onRefresh: () => ref.refresh(groupsStateProvider.future),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: gapH16),
              GroupsList(scrollController: scrollController),
            ],
          ),
        ),
      ),
    );
  }
}
