import 'package:flutter/material.dart';
import 'package:split_the_bill/models/group.dart';
import 'package:split_the_bill/providers/dummy_data_calls.dart';

class AddBillToGroupPopup extends StatelessWidget {
  const AddBillToGroupPopup(
      {Key? key,
      required this.icon,
      required this.closeFunction,
      required this.dummyCalls,
      required this.groups})
      : super(key: key);
  final Icon icon;
  final Function closeFunction;
  final DummyDataCalls dummyCalls;
  final List<Group> groups;

  //TODO use futurebuilder
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'openAddBillToGroupPopup',
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('To which Group should this bill be added?'),
          actions: groups
              .map((group) => createGroupTextButton(group, context))
              .toList(),
        ),
      ),
      child: icon,
    );
  }

  Widget createGroupTextButton(Group group, BuildContext context) {
    return TextButton(
        onPressed: () {
          closeFunction(group.id);
          Navigator.pop(context);
        },
        child: Text(group.name));
  }
}
