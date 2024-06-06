import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';
import 'package:split_the_bill/presentation/bills/unseen_bill/bill_contribution.dart';
import 'package:split_the_bill/presentation/bills/unseen_bill/controllers.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';

class UnseenBillScreen extends ConsumerWidget {
  const UnseenBillScreen({super.key, required this.billId});

  final String billId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bill = ref.watch(billStateProvider(billId));

    return AsyncValueWidget(
      value: bill,
      data: (bill) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Please confirm contribution"),
          ),
          floatingActionButton: ActionButton(
            icon: Icons.save,
            onPressed: () {
              _saveBill(bill, ref, context).then(
                (_) => GoRouter.of(context).pop(),
              );
            },
          ),
          body: BillContribution(bill: bill),
        );
      },
    );
  }

  Future<void> _saveBill(Bill bill, WidgetRef ref, BuildContext context) async {
    final contributions = ref.watch(itemsContributionsProvider(bill));

    await ref
        .read(billsStateProvider().notifier)
        .updateContributions(billId, contributions);
    ref.invalidate(billsStateProvider(isUnseen: true));
  }
}
