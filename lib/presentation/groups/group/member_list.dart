import 'package:flutter/material.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/app_sizes.dart';

class MemberListWidget extends StatelessWidget {
  const MemberListWidget({super.key, required this.members});

  final List<User> members;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: members.map((user) {
        return Column(
          children: [
            const CircleAvatar(
              radius: 36.0,
              backgroundImage: AssetImage('assets/avatar.jpg'),
            ),
            gapH8,
            Text(
              user.email,
              textAlign: TextAlign.center,
            ),
          ],
        );
      }).toList(),
    );
  }
}
