import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/presentation/bills/edit_bill/edit_bill.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';

class EditBillScreen extends ConsumerWidget {
  const EditBillScreen({super.key, required this.billId});
  final String billId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bill = ref.watch(billStateProvider(billId));

    return Scaffold(
      body: AsyncValueWidget(
        value: bill,
        data: (bill) => EditBill(bill: bill),
      ),
    );
  }
}
