import 'package:flutter/material.dart';
import 'package:split_the_bill/models/bill_mapping.dart';
import 'package:split_the_bill/widgets/screenTitle.dart';

import '../../providers/dummy_data_calls.dart';
import '../addObject/add_bill_page.dart';

class BillsPage extends StatefulWidget {
  const BillsPage(this.dummyCalls, {Key? key}) : super(key: key);
  final DummyDataCalls dummyCalls;

  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  late List<BillMapping> bills = widget.dummyCalls.getOwnBills();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [const ScreenTitle(text: "Bills page"), buildDataTable()],
      )),
    );
  }

  DataTable buildDataTable() {
    return DataTable(
      showCheckboxColumn: false,
      columns: const [
        DataColumn(label: Text("Bills")),
        DataColumn(label: Text("Price"))
      ],
      rows: bills.map((bill) => buildRow(bill)).toList(),
    );
  }

  ///Helper method to build a single row of the table.
  DataRow buildRow(BillMapping? billMapping) {
    return DataRow(
      cells: [
        DataCell(
          Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Text(billMapping!.bill.name),
            ),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Text(billMapping.bill.getTotalPrice().toString()),
            ),
          ),
        )
      ],
      onSelectChanged: (bool? values) =>
          navigateToAddBill(context, billMapping.bill.id),
    );
  }

  ///Helper method to navigate to addBillPage and update variables accordingly.
  Future<void> navigateToAddBill(BuildContext context, int billID) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddBillPage(billID,
            widget.dummyCalls.getGroupIDOfBill(billID), widget.dummyCalls)));
    setState(() {
      bills = widget.dummyCalls.getOwnBills();
    });
  }
}
