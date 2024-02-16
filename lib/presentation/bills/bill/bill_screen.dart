import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/presentation/bills/bill/items_list.dart';
import 'package:split_the_bill/presentation/shared/components/primary_button.dart';
import 'package:split_the_bill/routes.dart';

class BillScreen extends ConsumerWidget {
  const BillScreen({
    super.key,
    required this.groupId,
    required this.billId,
  });
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
        text: 'Edit',
        onPressed: () {
          context.goNamed(
            Routes.editBill.name,
            pathParameters: {
              'id': groupId,
              'billId': billId,
            },
          );
        },
      ),
      body: CustomScrollView(
        slivers: [
          ItemsList(
            scrollController: scrollController,
            bill: bill,
          ),
        ],
      ),
    );
  }
}
