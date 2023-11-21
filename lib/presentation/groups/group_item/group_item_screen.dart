import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';
import 'package:split_the_bill/presentation/groups/group_item/group_bills_silver_list.dart';

class GroupItemScreen extends ConsumerWidget {
  const GroupItemScreen({super.key, required this.groupId});
  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    final group = ref.watch(groupStateProvider(groupId));

    return Scaffold(
      appBar: AppBar(
        title: Text(group.value?.name ?? ""),
      ),
      body: CustomScrollView(
        slivers: [
          GroupBillsSilverList(
              scrollController: scrollController, groupId: groupId),
        ],
      ),
    );
  }
}
