import 'package:flutter/material.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/presentation/shared/components/fade_text.dart';
import 'package:split_the_bill/presentation/shared/extensions/currency_formatter.dart';
import 'package:split_the_bill/presentation/shared/profile/profile_image.dart';

class GroupMembers extends StatelessWidget {
  const GroupMembers({
    super.key,
    required this.members,
    required this.balance,
  });

  final List<User> members;
  final Map<String, double> balance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p24,
      ),
      child: _buildMemberItems(),
    );
  }

  Widget _buildMemberItems() {
    return CustomScrollView(
      slivers: members.map((user) {
        return SliverToBoxAdapter(
            child: Column(
          children: [
            gapH8,
            MemberItemWidget(user: user, balance: balance[user.id]),
          ],
        ));
      }).toList(),
    );
  }
}

class MemberItemWidget extends StatelessWidget {
  const MemberItemWidget(
      {super.key, required this.user, required this.balance});

  final User user;
  final double? balance;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        leading: ProfileImage(
          user: user,
          size: Sizes.p24,
        ),
        title: FadeText(
          text: user.getDisplayName(),
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        trailing: balance != null
            ? FadeText(
                text: balance!.toCurrencyString(),
                style: TextStyle(color: balance! >= 0 ? Colors.green: Colors.red, fontSize: 16),
              )
            : null,
      ),
    );
  }
}
