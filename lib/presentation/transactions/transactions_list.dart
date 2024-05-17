import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/domain/group/group_transaction.dart';
import 'package:split_the_bill/presentation/shared/components/headline.dart';
import 'package:split_the_bill/presentation/transactions/transaction_item.dart';

class TransactionsList extends ConsumerStatefulWidget {
  const TransactionsList({super.key, required this.transactions});

  final List<GroupTransaction> transactions;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionListState();
}

class _TransactionListState extends ConsumerState<TransactionsList> {
  late List<bool> transactionsExpanded;
  late List<GroupTransaction> transactions;

  List<GroupTransaction> _sortTransactions(
      List<GroupTransaction> transactions) {
    List<String> groups = transactions.map((e) => e.groupName).toList();
    groups = [
      ...{...groups}
    ];
    List<List<GroupTransaction>> sorted = [];

    for (var group in groups) {
      sorted.add(
          transactions.where((element) => element.groupName == group).toList());
    }

    sorted
        .map((list) => list.sort((a, b) => a.date.compareTo(b.date)))
        .toList();

    List<GroupTransaction> sortedGroupTransactions = [];
    for (var element in sorted) {
      sortedGroupTransactions.addAll(element);
    }

    return sortedGroupTransactions;
  }

  String _parseDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateToCheck = DateTime(date.year, date.month, date.day);
    if (dateToCheck == today) {
      return "Today";
    }
    if (date == today.subtract(const Duration(days: 1))) {
      return "Yesterday";
    } else {
      return '${date.day}.${date.month}.${date.year}';
    }
  }

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
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          for (int i = 0; i < transactions.length; i++) ...[
            if (i == 0 ||
                transactions[i].groupName != transactions[i - 1].groupName)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Headline(title: transactions[i].groupName),
              ),
            if (i == 0 ||
                transactions[i].date.isAfter(transactions[i - 1].date))
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  setState(() {
                    transactionsExpanded[i] = !transactionsExpanded[i];
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_parseDate(transactions[i].date)),
                    Icon(transactionsExpanded[i]
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down),
                  ],
                ),
              ),
            const Divider(),
            if (transactionsExpanded[i]) ...[
              TransactionItem(transaction: transactions[i].transactions[0])
            ],
          ]
        ],
      ),
    );
  }
}
