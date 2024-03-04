import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/presentation/shared/extensions/currency_formatter.dart';

class GroupTile extends ConsumerWidget {
  const GroupTile({
    super.key,
    required this.group,
    this.onTap,
  });

  final Group group;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).requireValue;
    double balance = group.balance[user.id] ?? 0;

    return Card(
      margin: const EdgeInsets.only(bottom: Sizes.p16),
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.all(Sizes.p16),
        leading: _buildGroupIcon(),
        title: Text(
          group.name,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        subtitle: _buildMemberAvatars(group),
        trailing: _buildBalanceInfo(balance),
        onTap: onTap,
      ),
    );
  }
}

Widget _buildGroupIcon() {
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

Widget _buildMemberAvatars(Group group) {
  return Row(
    children: [
      for (var member in group.members)
        const Padding(
          padding: EdgeInsets.only(right: 5.0),
          child: CircleAvatar(
            radius: 10,
            backgroundImage: AssetImage('assets/avatar.jpg'),
          ),
        ),
    ],
  );
}

Widget _buildBalanceInfo(double balance) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: Sizes.p8),
        child: Text(
          balance.toCurrencyString(),
          style: TextStyle(
            fontSize: 16.0,
            color: balance >= 0 ? Colors.green : Colors.red,
          ),
        ),
      ),
      const Icon(Icons.navigate_next),
    ],
  );
}
