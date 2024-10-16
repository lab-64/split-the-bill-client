import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation/shared/components/fade_text.dart';
import 'package:split_the_bill/presentation/shared/components/rounded_box.dart';

import '../../constants/ui_constants.dart';
import '../../domain/group/group_transaction.dart';

class TransactionGroupHeader extends StatelessWidget {
  const TransactionGroupHeader({
    super.key,
    required this.transaction,
  });

  final GroupTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return RoundedBox(
      firstPadding: const EdgeInsets.all(Sizes.p8),
      secondPadding: const EdgeInsets.all(Sizes.p8),
      backgroundColor: Colors.black12,
      child: ListTile(
        leading: const TransactionGroupLeadingIcon(),
        title: TransactionGroupTitle(transaction: transaction),
      ),
    );
  }
}

class TransactionGroupLeadingIcon extends StatelessWidget {
  const TransactionGroupLeadingIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.p40,
      height: Sizes.p40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.purple.shade300, Colors.purple.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Icon(
        Icons.home,
        color: Colors.white,
      ),
    );
  }
}

class TransactionGroupTitle extends StatelessWidget {
  const TransactionGroupTitle({
    super.key,
    required this.transaction,
  });

  final GroupTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return FadeText(
      text: transaction.groupName,
      style: const TextStyle(
        fontSize: Sizes.p16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
