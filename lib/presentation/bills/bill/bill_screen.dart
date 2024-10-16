import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';
import 'package:split_the_bill/presentation/bills/bill/bill_widget.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
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

  Future<void> _deleteBill(WidgetRef ref, Bill bill) async {
    await ref.read(billsStateProvider().notifier).delete(bill);
  }

  void _onSuccess(NavigatorState navigator, WidgetRef ref, bool isEdit) {
    final state = ref.watch(billsStateProvider());
    showSuccessSnackBar(
      navigator.context,
      state,
      isEdit ? 'Bill updated' : 'Bill deleted',
    );
  }

  bool _isBillOwner(WidgetRef ref) {
    return ref.read(billStateProvider(billId).notifier).isBillOwner();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bill = ref.watch(billStateProvider(billId));
    final user = ref.read(authStateProvider).requireValue;

    ref.listen(
      billsStateProvider(),
      (_, next) => next.showSnackBarOnError(context),
    );

    return AsyncValueWidget(
      value: bill,
      data: (bill) {
        final navigator = Navigator.of(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Bill"),
            actions: [
              IconButton(
                icon: const Icon(Icons.manage_accounts),
                onPressed: () => UnseenBillRoute(billId: billId).push(context),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => EditBillRoute(
                  groupId: bill.groupId,
                  billId: billId,
                ).push(context),
              ),
              if (_isBillOwner(ref))
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => showConfirmationDialog(
                    context: context,
                    title: "Are you sure, you want to delete this bill?",
                    content:
                    "This will delete the bill for you and all group members!",
                    onConfirm: () => _deleteBill(ref, bill).then(
                          (_) => _onSuccess(navigator, ref, false),
                    ),
                  ),
                ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
            child: RefreshIndicator(
              onRefresh: () => ref.refresh(billStateProvider(billId).future),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: BillWidget(
                      bill: bill,
                      userId: user.id,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
