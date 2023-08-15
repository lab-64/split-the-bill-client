import 'package:flutter/material.dart';
import 'package:split_the_bill/models/group.dart';
import 'package:split_the_bill/providers/dummy_data_calls.dart';

class GroupPage extends StatefulWidget {
  const GroupPage(this.groupID, {Key? key}) : super(key: key);

  final int groupID;

  @override
  State<GroupPage> createState() => _GroupPageState(groupID);
}

class _GroupPageState extends State<GroupPage> {
  late Group group;

  _GroupPageState(int id) {
    group = DummyDataCalls().getGroup(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          "Group Page",
          style: TextStyle(fontSize: 60),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(//TODO make into separate widget?
        type: BottomNavigationBarType.shifting,
        currentIndex: 0,
        onTap: (index) => Navigator.pop(context, index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'groups',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.group_add),
              label: 'add group',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'add Bill single',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'add Bill camera',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              label: 'bills',
              backgroundColor: Colors.blue),
        ],
      ),
    );
  }
}
