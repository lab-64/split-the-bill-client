import 'package:flutter/material.dart';

import '../../providers/dummy_data_calls.dart';

class AddBillPage extends StatefulWidget {
  const AddBillPage(this.dummyCalls, {Key? key}) : super(key: key);

  final DummyDataCalls dummyCalls;

  @override
  State<AddBillPage> createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Add Bill Page",
          style: TextStyle(fontSize: 60),
        ),
      ),
    );
  }
}
