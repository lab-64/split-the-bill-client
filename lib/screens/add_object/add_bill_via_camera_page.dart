import 'package:flutter/material.dart';

class AddBillPageViaCamera extends StatefulWidget {
  const AddBillPageViaCamera({Key? key}) : super(key: key);


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
