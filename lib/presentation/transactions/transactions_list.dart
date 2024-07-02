import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/data/auth_repository.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/group/group_transaction.dart';
import 'package:split_the_bill/domain/group/states/groups_transaction_state.dart';
import 'package:split_the_bill/presentation/shared/components/placeholder_display.dart';
import 'package:split_the_bill/presentation/transactions/transaction_item.dart';

import '../../domain/group/transaction.dart';
import '../shared/components/primary_button.dart';
import '../shared/components/rounded_box.dart';
import 'transaction_date_tab.dart';
import 'transaction_group_header.dart';

class TransactionsList extends ConsumerStatefulWidget {
  const TransactionsList(
      {super.key, required this.scrollController, required this.transactions});

  final List<GroupTransaction> transactions;
  final ScrollController scrollController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionListState();
}

class _TransactionListState extends ConsumerState<TransactionsList> {
  late List<bool> transactionsExpanded;
  late List<GroupTransaction> transactions;
  late List<GroupTransaction> originalTransactions;
  bool onlyOwn = false;

  @override
  void initState() {
    super.initState();
    _init(widget.transactions);
  }

  void _init(List<GroupTransaction> transactions) {
    this.transactions = List.generate(
        widget.transactions.length, (index) => transactions[index].copyWith());
    originalTransactions = List.generate(
        widget.transactions.length, (index) => transactions[index].copyWith());
    transactionsExpanded = List.generate(
        transactions.length,
        (index) => transactions[index] == transactions.last ||
                transactions[index].groupName !=
                    transactions[index + 1].groupName
            ? true
            : false);
  }

  void _filterTransactions() {
    final user = ref.read(authStateProvider).requireValue;
    setState(() {
      onlyOwn = !onlyOwn;
      if (onlyOwn) {
        for (var transaction in transactions) {
          transaction.transactions.removeWhere((transaction) =>
              transaction.creditor.id != user.id &&
              transaction.debtor.id != user.id);
        }
      } else {
        transactions = List.generate(originalTransactions.length,
            (index) => originalTransactions[index].copyWith());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      groupsTransactionStateProvider,
      (_, next) {
        _init(next.requireValue);
      },
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrimaryButton(
            onPressed: () => _filterTransactions(),
            icon: onlyOwn ? Icons.visibility_off : Icons.visibility,
            backgroundColor: Colors.purple.shade300,
            text: "Toggle visibility",
          ),
        ),
        ListView(
          controller: widget.scrollController,
          shrinkWrap: true,
          children: [
            if (transactions.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(Sizes.p16),
                  child: PlaceholderDisplay(
                    icon: Icons.currency_exchange,
                    message: "No recent transactions",
                  ),
                ),
              ),
            for (int i = 0; i < transactions.length; i++) ...[
              //first in group
              if (i == 0 ||
                  transactions[i].groupName != transactions[i - 1].groupName)
                TransactionGroupHeader(transaction: transactions[i]),
              //first for that date
              if (i == 0 ||
                  transactions[i].date.isAfter(transactions[i - 1].date))
                TransactionDateTab(
                  index: i,
                  onTap: invertTransactionExpanded,
                  transaction: transactions[i],
                  transactionExpanded: transactionsExpanded[i],
                ),
              //if open or last for the group
              if (transactionsExpanded[i] &&
                  transactions[i].transactions.isNotEmpty) ...[
                ListView.builder(
                    controller: widget.scrollController,
                    shrinkWrap: true,
                    itemCount: transactions[i].transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[i].transactions[index];
                      return TransactionItem(transaction: transaction);
                    })
              ],
              if (transactionsExpanded[i] &&
                  transactions[i].transactions.isEmpty)
                const RoundedBox(
                    firstPadding: EdgeInsets.only(
                        left: Sizes.p24,
                        right: Sizes.p24,
                        top: Sizes.p4,
                        bottom: Sizes.p4),
                    secondPadding: EdgeInsets.all(Sizes.p16),
                    backgroundColor: Colors.white,
                    child:
                        Center(child: Text("No money transactions necessary"))),
              if (i == transactions.length - 1) ...[gapH24]
            ]
          ],
        ),
      ],
    );
  }

  void invertTransactionExpanded(int i) {
    setState(() {
      transactionsExpanded[i] = !transactionsExpanded[i];
    });
  }
}
