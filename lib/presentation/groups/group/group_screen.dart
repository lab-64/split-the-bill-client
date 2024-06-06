import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
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

class GroupScreen extends ConsumerStatefulWidget {
  const GroupScreen({super.key, required this.groupId});

  final String groupId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GroupScreenState();
}

class _GroupScreenState extends ConsumerState<GroupScreen> {
  int _currentIndex = 0;

  void _updateCurrentIndex(BuildContext context) {
    void handleTabChange() {
      setState(() {
        _currentIndex = DefaultTabController.of(context).index;
      });
    }

    DefaultTabController.of(context).addListener(handleTabChange);
  }

  void _shareInvitation(BuildContext context, String invitationID) {
    Share.share(invitationID);
  }

  Future<void> _deleteGroup(WidgetRef ref) async {
    await ref.read(groupsStateProvider.notifier).delete(widget.groupId);
  }

  Future<void> _resetGroup(WidgetRef ref) async {
    await ref.read(groupsStateProvider.notifier).reset(widget.groupId);
  }

  bool _isGroupOwner(WidgetRef ref) {
    return ref.read(groupStateProvider(widget.groupId).notifier).isGroupOwner();
  }

  void _onSuccess(BuildContext context, WidgetRef ref, String message) {
    final state = ref.watch(groupsStateProvider);
    showSuccessSnackBar(
      context,
      state,
      message,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final group = ref.watch(groupStateProvider(widget.groupId));

    ref.listen(
      groupsStateProvider,
      (_, next) => next.showSnackBarOnError(context),
    );

    return DefaultTabController(
      length: 2,
      child: AsyncValueWidget(
        value: group,
        data: (group) => Builder(builder: (context) {
          _updateCurrentIndex(context);

          return Scaffold(
            floatingActionButton: ActionButton(
              icon: _currentIndex == 0 ? Icons.add : Icons.person_add,
              onPressed: () => _currentIndex == 0
                  ? EditBillRoute(
                      groupId: group.id,
                      billId: '0',
                    ).push(context)
                  : _shareInvitation(context, group.invitationID),
            ),
            appBar: AppBar(
              title: Text(group.name),
              actions: [
                if (_isGroupOwner(ref))
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () => EditGroupRoute(groupId: widget.groupId)
                            .push(context),
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
                      if (group.bills.isNotEmpty) ...[
                        PopupMenuItem(
                          child: const Row(
                            children: [
                              Icon(
                                Icons.autorenew,
                                color: Colors.orange,
                              ),
                              gapW16,
                              Text("Reset"),
                            ],
                          ),
                          onTap: () => showConfirmationDialog(
                            context: context,
                            title:
                                "Are you sure, you want to Reset this group?",
                            content:
                                "This will delete all bills for you and all group members!",
                            onConfirm: () => _resetGroup(ref).then(
                              (_) => _onSuccess(context, ref, 'Group reset'),
                            ),
                          ),
                        )
                      ],
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
                            (_) => _onSuccess(context, ref, "Group deleted"),
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
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
                  child: RefreshIndicator(
                    onRefresh: () =>
                        ref.refresh(groupStateProvider(group.id).future),
                    child: CustomScrollView(
                      slivers: [
                        const SliverToBoxAdapter(child: gapH16),
                        SliverToBoxAdapter(
                          child: BillsList(
                            scrollController: scrollController,
                            bills: group.bills,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GroupMembers(members: group.members),
                // const GroupHistory(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
