import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/presentation/shared/components/fade_text.dart';
import 'package:split_the_bill/presentation/shared/extensions/currency_formatter.dart';
import 'package:split_the_bill/presentation/shared/profile/profile_image.dart';

class BillTile extends ConsumerWidget {
  const BillTile({
    super.key,
    required this.bill,
    required this.onTap,
  });

  final Bill bill;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).requireValue;
    double balance = bill.balance[user.id] ?? 0;
    double total = bill.items.fold(0, (prev, item) => prev + item.price);

    return Card(
      margin: const EdgeInsets.only(bottom: Sizes.p16),
      color: Colors.white,
      elevation: 0,
      child: _buildListTile(total, balance, bill.owner),
    );
  }

  Widget _buildListTile(double total, double balance, User owner) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Sizes.p16,
        vertical: Sizes.p4,
      ),
      leading: _buildLeadingIcon(balance),
      title: _buildBillName(),
      subtitle: _buildSubtitle(owner),
      trailing: _buildTrailingAmount(total, balance),
    );
  }

  Widget _buildLeadingIcon(double balance) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: balance >= 0
              ? [Colors.green.shade300, Colors.green.shade700]
              : [Colors.red.shade300, Colors.red.shade700],
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

  Widget _buildBillName() {
    return FadeText(
      text: bill.name,
      style: const TextStyle(
        fontSize: 16.0,
      ),
    );
  }

  Widget _buildSubtitle(User owner) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOwnerRow(owner),
      ],
    );
  }

  Widget _buildOwnerRow(User owner) {
    return Row(
      children: [
        ProfileImage(
          user: owner,
          size: Sizes.p12,
        ),
        const SizedBox(width: Sizes.p4),
        Expanded(
          child: FadeText(
            text: owner.getDisplayName(),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildTrailingAmount(double total, double balance) {
    Color color;
    if (balance > 0) {
      color = Colors.green;
    } else if (balance < 0) {
      color = Colors.red;
    } else {
      color = Colors.black;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          total.toCurrencyString(),
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ),
        Text(
          balance.toCurrencyString(),
          style: TextStyle(
            fontSize: 14.0,
            color: color,
          ),
        )
      ],
    );
  }
}
