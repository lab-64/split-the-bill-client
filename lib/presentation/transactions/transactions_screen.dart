import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';
import 'package:split_the_bill/domain/group/states/groups_transaction_state.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/transactions/transactions_list.dart';

class TransactionScreen extends ConsumerWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(groupsTransactionStateProvider);
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
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
