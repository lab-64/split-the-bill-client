import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/presentation/bills/bill/bill_sliver_list_item.dart';

import '../../../routes.dart';
import '../../shared/primary_button.dart';

class BillItemScreen extends ConsumerWidget {
  const BillItemScreen(
      {super.key, required this.billId, required this.groupId});

  final String groupId;
  final String billId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    final bill = ref.watch(billStateProvider(billId));

    return Scaffold(
      appBar: AppBar(
        title: Text(bill.value?.name ?? ""),
      ),
      floatingActionButton: PrimaryButton(
        isLoading: false,
        text: 'Edit',
        onPressed: () {
          context.goNamed(
            Routes.editBill.name,
            pathParameters: {'id': groupId, 'billId': billId},
          );
        },
      ),
      body: CustomScrollView(
        slivers: [
          BillItemSliverList(
              scrollController: scrollController, billId: billId),
        ],
      ),
    );
  }
}
