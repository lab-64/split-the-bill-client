import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';
import 'package:split_the_bill/presentation/groups/group/group_members.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/bills/bills_list.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';
import 'package:split_the_bill/presentation/shared/components/show_confirmation_dialog.dart';
import 'package:split_the_bill/presentation/shared/components/snackbar.dart';
import 'package:split_the_bill/router/routes.dart';

class GroupScreen extends ConsumerWidget {
  const GroupScreen({
    super.key,
    required this.groupId,
  });

  final String groupId;

  Future<void> _deleteGroup(WidgetRef ref) async {
    await ref.read(groupsStateProvider.notifier).delete(groupId);
  }

  bool _isGroupOwner(WidgetRef ref) {
    return ref.read(groupStateProvider(groupId).notifier).isGroupOwner();
  }

  void _onSuccess(BuildContext context, WidgetRef ref, bool isEdit) {
    final state = ref.watch(groupsStateProvider);
    showSuccessSnackBar(
      context,
      state,
      isEdit ? 'Group updated' : 'Group deleted',
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    final group = ref.watch(groupStateProvider(groupId));

    ref.listen(
      groupsStateProvider,
      (_, next) => next.showSnackBarOnError(context),
    );

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
              if (_isGroupOwner(ref))
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
                      ),
                    ),
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
                        onConfirm: () => _deleteGroup(ref).then(
                          (_) => _onSuccess(context, ref, false),
                        ),
                      ),
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
