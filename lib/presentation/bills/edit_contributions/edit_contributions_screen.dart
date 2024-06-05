import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';

import '../../../domain/group/states/group_state.dart';
import '../../../domain/group/states/groups_state.dart';
import 'bill_contribution.dart';
import 'controllers.dart';

class EditContributionsScreen extends ConsumerWidget {
  const EditContributionsScreen({super.key, required this.billId});

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
    final contributionsMap = ref.watch(itemsContributionsProvider(bill));

    await ref.read(billsStateProvider().notifier).updateContributions(
        billId,
        contributionsMap);
    ref.invalidate(billsStateProvider(isUnseen: true));
    ref.invalidate(groupStateProvider);
    ref.invalidate(groupsStateProvider);
  }
}
