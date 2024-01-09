import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/bill/item_list_screen.dart';

import '../../../domain/group/states/group_state.dart';

class EditBillScreen extends ConsumerWidget {
  const EditBillScreen(
      {super.key, required this.groupId, required this.billId});

  final String groupId;
  final String billId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupStateProvider(groupId));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Bill"),
      ),
      body: AsyncValueWidget(
        value: group,
        data: (group) => ItemListScreen(
          isNewBill: true,
          existingItems:
              group.bills.firstWhere((bill) => bill.id == billId).items,
          group: group,
          billId: billId,
        ),
      ),
    );
  }
}
