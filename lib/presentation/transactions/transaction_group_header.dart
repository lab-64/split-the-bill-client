import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation/shared/components/rounded_box.dart';

import '../../constants/ui_constants.dart';
import '../../domain/group/group_transaction.dart';
import '../shared/components/ellipse_text.dart';

class TransactionGroupHeader extends StatelessWidget {
  const TransactionGroupHeader({
    super.key,
    required this.transaction,
  });

  final GroupTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return RoundedBox(
        firstPadding: const EdgeInsets.all(8.0),
        secondPadding: const EdgeInsets.all(8.0),
        backgroundColor: Colors.black12,
        child: ListTile(
          leading: const TransactionGroupLeadingIcon(),
          title: TransactionGroupTitle(transaction: transaction),
        ));
  }
}

class TransactionGroupLeadingIcon extends StatelessWidget {
  const TransactionGroupLeadingIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
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
    return EllipseText(
        text: transaction.groupName,
        size: Sizes.p64 * 3,
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold));
  }
}
