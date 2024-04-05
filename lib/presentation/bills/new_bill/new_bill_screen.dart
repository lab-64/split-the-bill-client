import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';
import 'package:split_the_bill/presentation/bills/new_bill/controllers.dart';
import 'package:split_the_bill/presentation/bills/new_bill/edit_bill.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';
import 'package:split_the_bill/presentation/shared/components/snackbar.dart';
import 'package:split_the_bill/router/routes.dart';

class NewBillScreen extends ConsumerWidget {
  const NewBillScreen({super.key, required this.groupId, this.billId = '0'});
  final String groupId;
  final String billId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bill = ref.watch(billStateProvider(billId));
    final group = ref.watch(groupStateProvider(groupId));

    return Scaffold(
      floatingActionButton: ActionButton(
        icon: Icons.save,
        onPressed: () => _addBill(ref).then(
          (_) => _onAddBillSuccess(ref, context),
        ),
      ),
      appBar: AppBar(title: const Text("New Bill")),
      body: AsyncValueWidget(
        value: group,
        data: (group) => AsyncValueWidget(
          value: bill,
          data: (bill) => EditBill(
            bill: bill,
            group: group,
          ),
        ),
      ),
    );
  }

  Future<void> _addBill(WidgetRef ref) async {
    return await ref.read(editBillControllerProvider.notifier).addBill(groupId);
  }

  void _onAddBillSuccess(WidgetRef ref, BuildContext context) {
    final state = ref.watch(editBillControllerProvider);
    showSuccessSnackBar(
      context,
      state,
      'Bill created',
      goTo: () => const HomeRoute().go(context),
    );
  }
}
