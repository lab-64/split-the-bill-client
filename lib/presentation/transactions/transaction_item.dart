import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/domain/group/transaction.dart';
import 'package:split_the_bill/presentation/shared/components/ellipse_text.dart';
import 'package:split_the_bill/presentation/shared/extensions/currency_formatter.dart';
import 'package:split_the_bill/presentation/shared/components/rounded_box.dart';

import '../../auth/states/auth_state.dart';
import '../../auth/user.dart';
import '../../constants/ui_constants.dart';

enum UserType { debtor, creditor, other }

class TransactionItem extends ConsumerWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.read(authStateProvider).requireValue;
    UserType userType;
    if (transaction.debtor.id == user.id) {
      userType = UserType.debtor;
    } else if (transaction.creditor.id == user.id) {
      userType = UserType.creditor;
    } else {
      userType = UserType.other;
    }
    return RoundedBox(
        firstPadding: const EdgeInsets.only(
            left: Sizes.p24, right: Sizes.p24, top: Sizes.p4, bottom: Sizes.p4),
        secondPadding: const EdgeInsets.all(Sizes.p8),
        backgroundColor: Colors.white,
        child: ListTile(
          leading: TransactionItemLeadingIcon(userType: userType),
          title: TransactionItemTitle(creditor: transaction.creditor),
          subtitle: TransactionItemSubTitle(debtor: transaction.debtor),
          trailing: TransactionItemTrailingAmount(
              amount: transaction.amount, userType: userType),
        ));
  }
}

class TransactionItemTrailingAmount extends StatelessWidget {
  const TransactionItemTrailingAmount({
    super.key,
    required this.amount,
    required this.userType,
  });

  final double amount;
  final UserType userType;

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (userType) {
      case UserType.creditor:
        color = Colors.green;
        break;
      case UserType.debtor:
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          amount.toCurrencyString(),
          style: TextStyle(fontSize: Sizes.p16, color: color),
        ),
      ],
    );
  }
}

class TransactionItemSubTitle extends StatelessWidget {
  const TransactionItemSubTitle({
    super.key,
    required this.debtor,
  });

  final User debtor;

  @override
  Widget build(BuildContext context) {
    return EllipseText(
      text: "From: ${debtor.getDisplayName()}",
      size: Sizes.p64 * 2,
      style: const TextStyle(
        fontSize: Sizes.p14,
      ),
    );
  }
}

class TransactionItemTitle extends StatelessWidget {
  const TransactionItemTitle({
    super.key,
    required this.creditor,
  });

  final User creditor;

  @override
  Widget build(BuildContext context) {
    return EllipseText(
      text: "To: ${creditor.getDisplayName()}",
      size: Sizes.p64 * 2,
      style: const TextStyle(
        fontSize: Sizes.p16,
      ),
    );
  }
}

class TransactionItemLeadingIcon extends StatelessWidget {
  const TransactionItemLeadingIcon({
    super.key,
    required this.userType,
  });

  final UserType userType;

  @override
  Widget build(BuildContext context) {
    List<Color> colors;
    switch (userType) {
      case UserType.creditor:
        colors = [Colors.green.shade300, Colors.green.shade700];
        break;
      case UserType.debtor:
        colors = [Colors.red.shade300, Colors.red.shade700];
        break;
      default:
        colors = [Colors.grey.shade300, Colors.grey.shade700];
    }
    return Container(
      width: Sizes.p40,
      height: Sizes.p40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
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
}
