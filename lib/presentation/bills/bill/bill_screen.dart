import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/presentation/bills/bill/bill_sliver_list_item.dart';

class BillItemScreen extends ConsumerWidget {
  const BillItemScreen({super.key, required this.billId});

  final String billId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    final bill = ref.watch(billStateProvider(billId));

    return Scaffold(
      appBar: AppBar(
        title: Text(bill.value?.name ?? ""),
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
