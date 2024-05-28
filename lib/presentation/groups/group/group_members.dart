import 'package:flutter/material.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/presentation/shared/components/fade_text.dart';
import 'package:split_the_bill/presentation/shared/profile/profile_image.dart';

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
      ),
    );
  }
}
