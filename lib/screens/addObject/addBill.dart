import 'package:flutter/material.dart';

class AddBillPage extends StatefulWidget {
  const AddBillPage({Key? key}) : super(key: key);

  @override
  State<AddBillPage> createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Add Bill Page"),
    );
  }
}
