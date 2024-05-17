import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/group/group_transaction.dart';
import 'package:split_the_bill/presentation/transactions/transaction_item.dart';

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

  @override
  void initState() {
    super.initState();
    transactions = _sortTransactions(widget.transactions);
    transactionsExpanded = List.generate(
        transactions.length,
        (index) => transactions[index] == transactions.last ||
                transactions[index].groupName !=
                    transactions[index + 1].groupName
            ? true
            : false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.scrollController,
      shrinkWrap: true,
      children: [
        for (int i = 0; i < transactions.length; i++) ...[
          //first in group
          if (i == 0 ||
              transactions[i].groupName != transactions[i - 1].groupName)
            TransactionGroupHeader(transaction: transactions[i]),
          //first for that date
          if (i == 0 || transactions[i].date.isAfter(transactions[i - 1].date))
            TransactionDateTab(
              i: i,
              invertTransactionExpanded: invertTransactionExpanded,
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
          if (i == transactions.length - 1) ...[gapH24]
        ]
      ],
    );
  }

  void invertTransactionExpanded(int i) {
    setState(() {
      transactionsExpanded[i] = !transactionsExpanded[i];
    });
  }

  List<GroupTransaction> _sortTransactions(
      List<GroupTransaction> transactions) {
    List<String> groups = transactions.map((e) => e.groupName).toList();
    groups = [
      ...{...groups}
    ];
    List<List<GroupTransaction>> sortedByGroup = [];

    for (var group in groups) {
      sortedByGroup.add(
          transactions.where((element) => element.groupName == group).toList());
    }

    sortedByGroup
        .map((list) => list.sort((a, b) => a.date.compareTo(b.date)))
        .toList();

    List<GroupTransaction> sortedGroupTransactions = [];
    for (var element in sortedByGroup) {
      sortedGroupTransactions.addAll(element);
    }

    return sortedGroupTransactions;
  }
}
