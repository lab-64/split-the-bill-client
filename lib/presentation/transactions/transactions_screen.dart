import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/transactions/controllers.dart';
import 'package:split_the_bill/presentation/transactions/transactions_list.dart';

class TransactionScreen extends ConsumerWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionsControllerProvider);
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AsyncValueWidget(
                value: transactions,
                data: (transactions) => TransactionsList(
                    transactions: transactions,
                    scrollController: scrollController)),
          ),
        ],
      ),
    );
  }
}
