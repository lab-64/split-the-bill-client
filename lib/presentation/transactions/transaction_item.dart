import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/domain/group/transaction.dart';

import '../../auth/states/auth_state.dart';

class TransactionItem extends ConsumerWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.read(authStateProvider).requireValue;
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(transaction.debtor.username == ''
                  ? transaction.debtor.email
                  : transaction.debtor.username),
              Icon(
                Icons.arrow_forward,
                color: transaction.debtor == user
                    ? Colors.red
                    : transaction.creditor == user
                        ? Colors.green
                        : Colors.grey,
              ),
              Text(transaction.creditor.username == ''
                  ? transaction.creditor.email
                  : transaction.creditor.username),
              const VerticalDivider(),
              Text("${transaction.amount} €")
            ],
          ),
        ),
      ),
    );
  }
}
