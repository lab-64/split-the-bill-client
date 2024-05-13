import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';
import 'package:split_the_bill/presentation/bills/new_bill/controllers.dart';
import 'package:split_the_bill/presentation/bills/new_bill/edit_bill.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
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
      appBar: AppBar(
        title: const Text("New Bill"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () => _addBill(ref, context),
                child: const Row(
                  children: [
                    Icon(
                      Icons.save,
                      color: Colors.blue,
                    ),
                    gapW8,
                    Text(
                      "Save",
                      style: TextStyle(fontSize: 18.0, color: Colors.blue),
                    )
                  ],
                )),
          )
        ],
      ),
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

  Future<void> _addBill(WidgetRef ref, BuildContext context) async {
    final items = ref.read(itemsProvider(billId));
    for (var item in items) {
      if(item.name == "" || item.price == 0.0){
        showErrorSnackBar(context, "Please give all items a name and a price other than 0.0€!");
        return;
      }
    }
    return await ref
        .read(editBillControllerProvider.notifier)
        .addBill(groupId)
        .then((_) => _onAddBillSuccess(ref, context));
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
