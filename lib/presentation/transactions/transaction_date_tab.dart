import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation/shared/components/rounded_box.dart';

import '../../constants/ui_constants.dart';
import '../../domain/group/group_transaction.dart';

class TransactionDateTab extends StatelessWidget {
  const TransactionDateTab({
    super.key,
    required this.i,
    required this.invertTransactionExpanded,
    required this.transaction,
    required this.transactionExpanded,
  });

  final int i;
  final Function invertTransactionExpanded;
  final GroupTransaction transaction;
  final bool transactionExpanded;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => invertTransactionExpanded(i),
      child: RoundedBox(
          firstPadding:
              const EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 16),
          secondPadding: const EdgeInsets.all(8.0),
          backgroundColor: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  gapW8,
                  Text(
                    _parseDate(transaction.date),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    transactionExpanded
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                  gapW8
                ],
              ),
            ],
          )),
    );
  }

  String _parseDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateToCheck = DateTime(date.year, date.month, date.day);
    final months = [
      'January',
      'February',
      'March',
      'April',
      'Mai',
      'June',
      'Juli',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    if (dateToCheck == today) {
      return "Today";
    }
    //TODO better way to find yesterday, this way it has to be 24 hrs ago
    if (date == today.subtract(const Duration(days: 1))) {
      return "Yesterday";
    } else {
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    }
  }
}
