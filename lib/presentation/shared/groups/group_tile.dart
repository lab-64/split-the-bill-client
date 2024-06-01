import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/presentation/shared/components/fade_text.dart';
import 'package:split_the_bill/presentation/shared/extensions/currency_formatter.dart';
import 'package:split_the_bill/presentation/shared/profile/profile_image.dart';

class GroupTile extends ConsumerWidget {
  const GroupTile({
    super.key,
    required this.group,
    this.onTap,
    this.isDetailed = true,
  });

  final Group group;
  final VoidCallback? onTap;
  final bool isDetailed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).requireValue;
    double balance = group.balance[user.id] ?? 0;

    return Card(
      margin: const EdgeInsets.only(bottom: Sizes.p16),
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          vertical: isDetailed ? Sizes.p16 : Sizes.p4,
          horizontal: Sizes.p16,
        ),
        leading: _buildGroupIcon(),
        title: FadeText(
          text: group.name,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        subtitle: _buildMemberAvatars(group),
        trailing: isDetailed ? _buildBalanceInfo(balance) : null,
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
        Padding(
          padding: const EdgeInsets.only(right: Sizes.p4),
          child: ProfileImage(
            user: member,
            size: Sizes.p12,
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
