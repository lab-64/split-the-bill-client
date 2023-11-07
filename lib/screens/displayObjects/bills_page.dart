import 'package:flutter/material.dart';

import '../../providers/dummy_data_calls.dart';

class BillsPage extends StatefulWidget {
  const BillsPage(this.dummyCalls, {Key? key}) : super(key: key);

  final DummyDataCalls dummyCalls;

  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Bills Page",
          style: TextStyle(fontSize: 60),
        ),
      ),
    );
  }
}
