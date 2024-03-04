import 'package:flutter/material.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/app_sizes.dart';

class GroupMembers extends StatelessWidget {
  const GroupMembers({
    super.key,
    required this.members,
  });

  final List<User> members;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p24,
        vertical: Sizes.p16,
      ),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: _buildMemberItems(),
      ),
    );
  }

  List<Widget> _buildMemberItems() {
    return members.map((user) {
      return MemberItemWidget(user: user);
    }).toList();
  }
}

class MemberItemWidget extends StatelessWidget {
  const MemberItemWidget({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: Sizes.p32,
          backgroundImage: AssetImage('assets/avatar.jpg'),
        ),
        gapH8,
        Text(
          user.email,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
