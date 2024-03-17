import 'package:flutter/material.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/app_sizes.dart';

class GroupMemberList extends StatefulWidget {
  const GroupMemberList({super.key, required this.members});

  final List<User> members;

  @override
  State<GroupMemberList> createState() => _GroupMemberListState();
}

class _GroupMemberListState extends State<GroupMemberList> {
  List<bool> _isSelectedList = [];

  @override
  void initState() {
    super.initState();
    _isSelectedList = List<bool>.filled(widget.members.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizes.p8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: widget.members.length,
          itemBuilder: (BuildContext context, int index) {
            return CheckboxListTile(
              secondary: const CircleAvatar(
                backgroundImage: AssetImage('assets/avatar.jpg'),
                radius: 20,
              ),
              dense: true,
              selectedTileColor: Colors.red,
              controlAffinity: ListTileControlAffinity.trailing,
              title: Text(widget.members[index].email),
              value: _isSelectedList[index],
              onChanged: (bool? value) {
                setState(() {
                  _isSelectedList[index] = value!;
                });
              },
            );
          },
        ),
      ),
    );
  }
}
