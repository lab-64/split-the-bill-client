import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';
import 'package:split_the_bill/presentation/groups/group/group_history.dart';
import 'package:split_the_bill/presentation/groups/group/member_list.dart';
import 'package:split_the_bill/presentation/groups/groups/bills_list.dart';

class GroupScreen extends ConsumerWidget {
  const GroupScreen({super.key, required this.groupId});
  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    final group = ref.watch(groupStateProvider(groupId));

    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your action when the button is pressed
          },
          elevation: 4.0,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          child: Icon(Icons.more_vert),
        ),
        appBar: AppBar(
          title: Text(group.value?.name ?? ""),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.receipt),
              ),
              Tab(
                icon: Icon(Icons.people),
              ),
              Tab(
                icon: Icon(Icons.history),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.p24, vertical: Sizes.p16),
              child: CustomScrollView(
                slivers: [
                  BillsList(
                      scrollController: scrollController,
                      groupId: groupId,
                      showGroup: false),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.p24, vertical: Sizes.p16),
              child: MemberListWidget(
                members: group.requireValue.members,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.p24, vertical: Sizes.p16),
              child: GroupHistory(),
            ),
          ],
        ),
      ),
    );
  }
}
