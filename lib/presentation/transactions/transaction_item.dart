import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/domain/group/transaction.dart';

class TransactionItem extends ConsumerWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //var user =  ref.read(authStateProvider).requireValue; //TODO use actual user
    var user = 'user1';
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(transaction.debtor.username),
              Icon(
                Icons.arrow_forward,
                color: transaction.debtor.username == user
                    ? Colors.red
                    : transaction.creditor.username == user
                        ? Colors.green
                        : Colors.grey,
              ),
              Text(transaction.creditor.username),
              const VerticalDivider(),
              Text(transaction.amount.toString())
            ],
          ),
        ),
      ),
    );
  }
}
