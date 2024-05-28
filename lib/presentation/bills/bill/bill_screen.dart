import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';
import 'package:split_the_bill/presentation/bills/bill/items_list.dart';
import 'package:split_the_bill/presentation/shared/components/show_confirmation_dialog.dart';
import 'package:split_the_bill/presentation/shared/components/snackbar.dart';
import 'package:split_the_bill/router/routes.dart';

import '../../../auth/states/auth_state.dart';

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
    final user = ref.read(authStateProvider).requireValue;

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
                onTap: () => EditBillRoute(
                  groupId: bill.requireValue.groupId,
                  billId: billId,
                ).push(context),
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
        child: RefreshIndicator(
          onRefresh: () => ref.refresh(billStateProvider(billId).future),
          child: CustomScrollView(
            slivers: [
              ItemsList(
                userId: user.id,
                scrollController: scrollController,
                bill: bill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
