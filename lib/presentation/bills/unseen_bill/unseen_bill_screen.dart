import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/item.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';
import 'package:split_the_bill/presentation/bills/unseen_bill/bill_contribution.dart';
import 'package:split_the_bill/presentation/bills/unseen_bill/controllers.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';
import 'package:split_the_bill/presentation/shared/components/snackbar.dart';

class UnseenBillScreen extends ConsumerWidget {
  const UnseenBillScreen({super.key, required this.billId});
  final String billId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bill = ref.watch(billStateProvider(billId));
    final items = ref.watch(itemsContributionsProvider);

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
              if (items.length < bill.items.length) {
                showErrorSnackBar(
                  context,
                  'Please view all items before saving!',
                );
              } else {
                _saveBill(bill, items, ref, context).then(
                  (_) => GoRouter.of(context).pop(),
                );
              }
            },
            disabled: items.length < bill.items.length,
          ),
          body: BillContribution(bill: bill),
        );
      },
    );
  }

  Future<void> _saveBill(
      Bill bill, List<Item> items, WidgetRef ref, BuildContext context) async {
    // TODO:
    // When backend is adjusted, we will only call "editBill" once with all items
    // instead of calling "editItem" for each item
    for (var item in items) {
      await ref.read(billStateProvider(billId).notifier).editItem(item);
    }

    bill = bill.copyWith(isViewed: true);
    await ref.read(billsStateProvider().notifier).edit(bill);
    ref.invalidate(billsStateProvider(isUnseen: true));
  }
}
