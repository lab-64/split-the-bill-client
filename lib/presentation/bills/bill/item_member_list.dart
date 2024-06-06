import 'package:flutter/material.dart';

import '../../../auth/user.dart';
import '../../../constants/ui_constants.dart';
import '../../shared/components/fade_text.dart';
import '../../shared/profile/profile_image.dart';

class ItemMemberList extends StatelessWidget {
  const ItemMemberList({super.key, required this.members});

  final List<User> members;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _getSize(members.length),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: members.length > 3
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            itemCount: members.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  leading: ProfileImage(
                    user: members[index],
                    size: Sizes.p20,
                  ),
                  title: FadeText(
                    text: members[index].getDisplayName(),
                    style: const TextStyle(color: Colors.grey),
                  ));
            }),
      ),
    );
  }

  double _getSize(int amount) {
    if (amount >= 3) {
      return 180;
    }
    if (amount == 2) {
      return 120;
    } else {
      return 70;
    }
  }
}
