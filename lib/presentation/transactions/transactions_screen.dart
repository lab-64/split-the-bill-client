import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/domain/group/states/groups_transaction_state.dart';
import 'package:split_the_bill/domain/tutorial/tutorial_state.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/tutorial_help_button.dart';
import 'package:split_the_bill/presentation/shared/components/tutorial_popup.dart';
import 'package:split_the_bill/presentation/transactions/transactions_list.dart';

class TransactionScreen extends ConsumerWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(groupsTransactionStateProvider);
    final ScrollController scrollController = ScrollController();

    final isTutorialSeen =
        ref.watch(tutorialControllerProvider(TutorialScreen.transactions));

    if (!isTutorialSeen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showTutorialDialog(
          context: context,
          screen: TutorialScreen.transactions,
          onDismiss: () => ref
              .read(tutorialControllerProvider(TutorialScreen.transactions).notifier)
              .markAsSeen(),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        actions: [
          if (isTutorialSeen)
            TutorialHelpButton(
              onPressed: () => showTutorialDialog(
                context: context,
                screen: TutorialScreen.transactions,
              ),
            ),
        ],
      ),
      body: AsyncValueWidget(
        value: transactions,
        data: (transactions) => RefreshIndicator(
          onRefresh: () => ref.refresh(groupsTransactionStateProvider.future),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: TransactionsList(
                  transactions: transactions,
                  scrollController: scrollController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
