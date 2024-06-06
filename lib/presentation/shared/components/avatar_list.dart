import 'dart:math';

import 'package:flutter/material.dart';

import '../../../auth/user.dart';
import '../../../constants/ui_constants.dart';
import '../profile/profile_image.dart';

class AvatarList extends StatelessWidget {
  final List<User> users;

  const AvatarList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double singleChildWidth = Sizes.p24;
        int maxVisibleAvatars =
            (constraints.maxWidth / singleChildWidth).floor();

        return Row(
          children: [
            for (var i = 0; i < min(maxVisibleAvatars, users.length); i++)
              if (users.length - (maxVisibleAvatars - 1) > 1 &&
                  i == min(maxVisibleAvatars, users.length) - 1) ...[
                const SizedBox(width: Sizes.p4),
                Text("+${users.length - (maxVisibleAvatars - 1)}"),
              ] else
                Padding(
                  padding: const EdgeInsets.only(right: Sizes.p4),
                  child: ProfileImage(
                    user: users[i],
                    size: Sizes.p12,
                  ),
                ),
          ],
        );
      },
    );
  }
}
