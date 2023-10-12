import 'package:flutter/material.dart';
import 'package:split_the_bill/models/group.dart';
import 'package:split_the_bill/providers/dummy_data_calls.dart';

class AddBillToGroupPopup extends StatelessWidget {
  const AddBillToGroupPopup(this.dummyCalls, this.closeFunction, this.icon, {Key? key})
      : super(key: key);
  final Icon icon;
  final Function closeFunction;
  final DummyDataCalls dummyCalls;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'openAddBillToGroupPopup',
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('To which Group should this bill be added?'),
          actions: dummyCalls
              .getOwnGroups()
              .map((group) => createItem(group, context))
              .toList(),
        ),
      ),
      child: icon,
    );
  }

  Widget createItem(Group group, BuildContext context) {
    return TextButton(
        onPressed: () {
          closeFunction(group.id);
          Navigator.pop(context);
        },
        child: Text(group.name));
  }
}
