import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';
import 'package:split_the_bill/domain/tutorial/tutorial_state.dart';
import 'package:split_the_bill/presentation/bills/unseen_bill/bill_contribution.dart';
import 'package:split_the_bill/presentation/bills/unseen_bill/controllers.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';
import 'package:split_the_bill/presentation/shared/components/tutorial_help_button.dart';
import 'package:split_the_bill/presentation/shared/components/tutorial_popup.dart';

class UnseenBillScreen extends ConsumerWidget {
  const UnseenBillScreen({super.key, required this.billId});

  final String billId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bill = ref.watch(billStateProvider(billId));

    final isTutorialSeen =
        ref.watch(tutorialControllerProvider(TutorialScreen.unseenBill));

    if (!isTutorialSeen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showTutorialDialog(
          context: context,
          screen: TutorialScreen.unseenBill,
          onDismiss: () => ref
              .read(tutorialControllerProvider(TutorialScreen.unseenBill).notifier)
              .markAsSeen(),
        );
      });
    }

    return AsyncValueWidget(
      value: bill,
      data: (bill) {
        final goRouter = GoRouter.of(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Please confirm contribution"),
            actions: [
              if (isTutorialSeen)
                TutorialHelpButton(
                  onPressed: () => showTutorialDialog(
                    context: context,
                    screen: TutorialScreen.unseenBill,
                  ),
                ),
            ],
          ),
          floatingActionButton: ActionButton(
            icon: Icons.save,
            onPressed: () {
              _saveBill(bill, ref, context).then(
                (_) => goRouter.pop(),
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
    ref.invalidate(billStateProvider(billId));
    ref.invalidate(groupsStateProvider);
    ref.invalidate(groupStateProvider);
  }
}
