import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:split_the_bill/presentation/shared/components/rounded_box.dart';

import '../../constants/ui_constants.dart';
import '../../domain/group/group_transaction.dart';

class TransactionDateTab extends StatelessWidget {
  const TransactionDateTab({
    super.key,
    required this.index,
    required this.onTap,
    required this.transaction,
    required this.transactionExpanded,
  });

  final int index;
  final Function onTap;
  final GroupTransaction transaction;
  final bool transactionExpanded;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onTap(index),
      child: RoundedBox(
          firstPadding: const EdgeInsets.only(
              top: Sizes.p4,
              bottom: Sizes.p4,
              left: Sizes.p16,
              right: Sizes.p16),
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
    if (date.difference(DateTime.now()).inDays == 0) {
      return "Today";
    }
    if (date.difference(DateTime.now()).inDays == 0) {
      return "Yesterday";
    } else {
      return DateFormat.yMMMd('en_US').format(date);
    }
  }
}
