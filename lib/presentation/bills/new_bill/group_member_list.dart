import 'package:flutter/material.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/presentation/shared/components/fade_text.dart';
import 'package:split_the_bill/presentation/shared/profile/profile_image.dart';

class GroupMemberList extends StatefulWidget {
  const GroupMemberList({
    super.key,
    required this.members,
    required this.contributors,
    required this.onChanged,
  });

  final List<User> members;
  final List<User> contributors;
  final Function(List<User>) onChanged;

  @override
  State<GroupMemberList> createState() => _GroupMemberListState();
}

class _GroupMemberListState extends State<GroupMemberList> {
  List<bool> _isSelectedList = [];
  List<User> contributors = [];

  @override
  void initState() {
    super.initState();
    contributors = List.from(widget.contributors);
    _isSelectedList = List.generate(widget.members.length, (index) {
      final memberId = widget.members[index].id;
      return contributors.any((contributor) => contributor.id == memberId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Sizes.p16),
        ),
        height: 100,
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.members.length,
            itemBuilder: (BuildContext context, int index) {
              return CheckboxListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.p16),
                ),
                secondary: ProfileImage(
                  user: widget.members[index],
                  size: Sizes.p20,
                ),
                dense: true,
                title: FadeText(
                  text: widget.members[index].getDisplayName(),
                  style: const TextStyle(),
                ),
                value: _isSelectedList[index],
                onChanged: (bool? value) {
                  setState(() {
                    _isSelectedList[index] = value!;
                    if (value) {
                      contributors.add(widget.members[index]);
                    } else {
                      contributors.removeWhere((contributor) =>
                          contributor.id == widget.members[index].id);
                    }
                  });
                  widget.onChanged(contributors);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
