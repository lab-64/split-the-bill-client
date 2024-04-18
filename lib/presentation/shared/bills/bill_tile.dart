import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/presentation/shared/components/ellipse_profile_name.dart';
import 'package:split_the_bill/presentation/shared/extensions/currency_formatter.dart';
import 'package:split_the_bill/presentation/shared/profile/profile_image.dart';

class BillTile extends ConsumerWidget {
  const BillTile({
    super.key,
    required this.bill,
    required this.showGroup,
    required this.onTap,
  });

  final Bill bill;
  final bool showGroup;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).requireValue;
    double balance = bill.balance[user.id] ?? 0;

    return Card(
      margin: const EdgeInsets.only(bottom: Sizes.p16),
      elevation: 0,
      child: _buildListTile(balance, bill.owner),
    );
  }

  Widget _buildListTile(double balance, User owner) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Sizes.p16,
        vertical: Sizes.p4,
      ),
      leading: _buildLeadingIcon(balance),
      title: _buildBillName(),
      subtitle: _buildSubtitle(owner),
      trailing: _buildTrailingAmount(balance),
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
    return Text(
      bill.name,
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
        Visibility(
          visible: showGroup,
          child: _buildGroupRow(),
        ),
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
        EllipseProfileName(
          name: owner.getDisplayName(),
          size: Sizes.p64 * 2,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildGroupRow() {
    return Row(
      children: [
        Container(
          width: 16.0,
          height: 16.0,
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
            size: 10,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: Sizes.p4),
        const Text(
          "Some Group", // TODO
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildTrailingAmount(double balance) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          balance.toCurrencyString(),
          style: TextStyle(
            fontSize: 16.0,
            color: balance >= 0 ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}
