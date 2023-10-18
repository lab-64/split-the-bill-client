import 'package:flutter/material.dart';

import '../../providers/dummy_data_calls.dart';

class AddMemberPage extends StatefulWidget {
  const AddMemberPage(this.dummyCalls, {Key? key}) : super(key: key);

  final DummyDataCalls dummyCalls;

  @override
  State<AddMemberPage> createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Add Member Page",
          style: TextStyle(fontSize: 60),
        ),
      ),
    );
  }
}
