import 'package:flutter/material.dart';
import 'package:split_the_bill/models/bill_mapping.dart';

import '../../providers/dummy_data_calls.dart';
import '../addObject/add_bill_page.dart';

class BillsPage extends StatefulWidget {
  const BillsPage(this.changeIndex, this.dummyCalls, {Key? key})
      : super(key: key);

  final DummyDataCalls dummyCalls;
  final Function changeIndex;

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
        children: [
          const SelectionContainer.disabled(
              child: Text(
            "Bills Page",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40, height: 5),
          )),
          DataTable(
            showCheckboxColumn: false,
            columns: const [
              DataColumn(label: Text("Bills")),
              DataColumn(label: Text("Price"))
            ],
            rows: buildAllRows(),
          )
        ],
      )),
    );
  }

  ///Helper method to build rows of a table.
  List<DataRow> buildAllRows() {
    return bills.map((bill) => buildRow(bill)).toList();
  }

  ///Helper method to build a single row of the table.
  DataRow buildRow(BillMapping? billMapping) {
    return DataRow(cells: [
      DataCell(
        Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Text(billMapping!.bill.name),
          ),
        ),
        onTap: () => navigateToAddBill(context),
      ),
      DataCell(
        Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Text(billMapping.bill.price.toString()),
          ),
        ),
      )
    ]);
  }

  ///Helper method to navigate to addBillPage and update variables accordingly.
  Future<void> navigateToAddBill(BuildContext context) async {
    final res = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            AddBillPage(widget.changeIndex, widget.dummyCalls, -1, -1)));
    //TODO remove
    BillMapping test = BillMapping(widget.dummyCalls.users[0],
        widget.dummyCalls.bills[0], [widget.dummyCalls.users[0]]);
    setState(() {
      bills.add(test);
    });
  }
}
