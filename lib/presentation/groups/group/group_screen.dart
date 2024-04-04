import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';
import 'package:split_the_bill/presentation/groups/group/group_members.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/bills/bills_list.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';
import 'package:split_the_bill/router/routes.dart';

class GroupScreen extends ConsumerWidget {
  const GroupScreen({
    super.key,
    required this.groupId,
  });

  final String groupId;

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
