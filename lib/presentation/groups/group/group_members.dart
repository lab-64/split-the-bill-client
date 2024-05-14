import 'package:flutter/material.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/presentation/shared/profile/profile_image.dart';

import '../../shared/components/ellipse_text.dart';

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
        ProfileImage(
          user: user,
          size: Sizes.p32,
        ),
        gapH8,
        EllipseText(
          text: user.getDisplayName(),
          size: Sizes.p64,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
