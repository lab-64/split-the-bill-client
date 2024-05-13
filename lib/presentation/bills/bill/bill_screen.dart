import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';
import 'package:split_the_bill/presentation/bills/bill/items_list.dart';
import 'package:split_the_bill/presentation/shared/components/show_confirmation_dialog.dart';
import 'package:split_the_bill/presentation/shared/components/snackbar.dart';

class BillScreen extends ConsumerWidget {
  const BillScreen({
    super.key,
    required this.billId,
  });

  final String billId;

  Future<void> _deleteBill(WidgetRef ref) async {
    await ref.read(billsStateProvider().notifier).delete(billId);
  }

  void _onSuccess(BuildContext context, WidgetRef ref, bool isEdit) {
    final state = ref.watch(billsStateProvider());
    showSuccessSnackBar(
      context,
      state,
      isEdit ? 'Bill updated' : 'Bill deleted',
    );
  }

  bool _isBillOwner(WidgetRef ref) {
    return ref.read(billStateProvider(billId).notifier).isBillOwner();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    final bill = ref.watch(billStateProvider(billId));

    ref.listen(
      billsStateProvider(),
      (_, next) => next.showSnackBarOnError(context),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(bill.value?.name ?? ""),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  showNotImplementedSnackBar(context);
                  /*context.goNamed(
                            Routes.editBill.name,
                            pathParameters: {
                              //'id': groupId,
                              'id': billId,
                            },
                          );*/
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.blueAccent,
                    ),
                    gapW16,
                    Text("Edit")
                  ],
                ),
              ),
              if (_isBillOwner(ref))
                PopupMenuItem(
                  child: const Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      gapW16,
                      Text("Delete"),
                    ],
                  ),
                  onTap: () => showConfirmationDialog(
                    context: context,
                    title: "Are you sure, you want to delete this bill?",
                    content:
                        "This will delete the bill for you and all group members!",
                    onConfirm: () => _deleteBill(ref).then(
                      (_) => _onSuccess(context, ref, false),
                    ),
                  ),
                ),
            ],
            position: PopupMenuPosition.under,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
        child: CustomScrollView(
          slivers: [
            ItemsList(
              scrollController: scrollController,
              bill: bill,
            ),
          ],
        ),
      ),
    );
  }
}
