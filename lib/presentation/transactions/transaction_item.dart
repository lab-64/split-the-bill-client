import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/domain/group/transaction.dart';
import 'package:split_the_bill/presentation/shared/components/ellipse_text.dart';
import 'package:split_the_bill/presentation/shared/extensions/currency_formatter.dart';
import 'package:split_the_bill/presentation/shared/components/rounded_box.dart';

import '../../auth/states/auth_state.dart';
import '../../auth/user.dart';
import '../../constants/ui_constants.dart';

class TransactionItem extends ConsumerWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.read(authStateProvider).requireValue;
    int userType = transaction.debtor == user
        ? 0
        : transaction.creditor == user
            ? 1
            : 2;
    return RoundedBox(
        firstPadding:
            const EdgeInsets.only(left: 24, right: 24, top: 4, bottom: 4),
        secondPadding: const EdgeInsets.all(8.0),
        backgroundColor: Colors.white,
        child: ListTile(
          leading: _buildLeadingIcon(userType),
          title: _buildTransactionTitle(transaction.creditor),
          subtitle: _buildTransactionSubTitle(transaction.debtor),
          trailing: _buildTrailingAmount(transaction.amount, userType),
        ));
  }
}

Widget _buildLeadingIcon(int userType) {
  return Container(
    width: 40.0,
    height: 40.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: userType == 0
            ? [Colors.red.shade300, Colors.red.shade700]
            : userType == 1
                ? [Colors.green.shade300, Colors.green.shade700]
                : [Colors.grey.shade300, Colors.grey.shade700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: const Icon(
      Icons.attach_money,
      color: Colors.white,
    ),
  );
}

Widget _buildTransactionTitle(User creditor) {
  return EllipseText(
    text:
        "To: ${creditor.username.isEmpty ? creditor.email : creditor.username}",
    size: Sizes.p64 * 2,
    style: const TextStyle(
      fontSize: 16.0,
    ),
  );
}

Widget _buildTransactionSubTitle(User debtor) {
  return EllipseText(
    text: "From: ${debtor.username.isEmpty ? debtor.email : debtor.username}",
    size: Sizes.p64 * 2,
    style: const TextStyle(
      fontSize: 14.0,
    ),
  );
}

Widget _buildTrailingAmount(double balance, int userType) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        balance.toCurrencyString(),
        style: TextStyle(
          fontSize: 16.0,
          color: userType == 0
              ? Colors.red
              : userType == 1
                  ? Colors.green
                  : Colors.grey,
        ),
      ),
    ],
  );
}
