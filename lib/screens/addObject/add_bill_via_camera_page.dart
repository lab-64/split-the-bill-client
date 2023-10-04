import 'package:flutter/material.dart';

import '../../providers/dummy_data_calls.dart';

class AddBillPageViaCamera extends StatefulWidget {
  const AddBillPageViaCamera(this.dummyCalls, {Key? key}) : super(key: key);

  final DummyDataCalls dummyCalls;

  @override
  State<AddBillPageViaCamera> createState() => _AddBillPageViaCameraState();
}

class _AddBillPageViaCameraState extends State<AddBillPageViaCamera> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Add Bill via Camera Page",
          style: TextStyle(fontSize: 60),
        ),
      ),
    );
  }
}