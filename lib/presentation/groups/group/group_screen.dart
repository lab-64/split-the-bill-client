import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';
import 'package:split_the_bill/presentation/groups/group/group_members.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/bills/bills_list.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';
import 'package:split_the_bill/presentation/shared/components/show_confirmation_dialog.dart';
import 'package:split_the_bill/router/routes.dart';

import '../../../domain/group/states/groups_state.dart';

class GroupScreen extends ConsumerWidget {
  const GroupScreen({
    super.key,
    required this.groupId,
  });

  final String groupId;

  void _deleteGroup(WidgetRef ref) async {
    ref.read(groupsStateProvider.notifier).delete(groupId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    final group = ref.watch(groupStateProvider(groupId));

    return DefaultTabController(
      length: 2,
      child: AsyncValueWidget(
        value: group,
        data: (group) => Scaffold(
          floatingActionButton: ActionButton(
            icon: Icons.add,
            onPressed: () => NewBillRoute(groupId: group.id).push(context),
          ),
          appBar: AppBar(
            title: Text(group.name),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                      onTap: () =>
                          EditGroupRoute(groupId: groupId).push(context),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.blueAccent,
                          ),
                          gapW16,
                          Text("Edit")
                        ],
                      )),
                  PopupMenuItem(
                    child: const Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        gapW16,
                        Text("Delete"),
                      ],
                    ),
                    onTap: () => showConfirmationDialog(
                        context: context,
                        title: "Are you sure, you want to delete this group?",
                        content:
                            "This will delete the group for you and all group members!",
                        onConfirm: () {
                          _deleteGroup(ref);
                          const HomeRoute().go(context);
                        }),
                  ),
                ],
                position: PopupMenuPosition.under,
              )
            ],
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.receipt_long),
                ),
                Tab(
                  icon: Icon(Icons.people),
                ),
                /* TODO: Implement GroupHistory in backend
                Tab(
                  icon: Icon(Icons.history),
                ),
                */
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(child: gapH16),
                    BillsList(
                      scrollController: scrollController,
                      groupId: groupId,
                      showGroup: false,
                    ),
                  ],
                ),
              ),
              GroupMembers(members: group.members),
              // const GroupHistory(),
            ],
          ),
        ),
      ),
    );
  }
}
