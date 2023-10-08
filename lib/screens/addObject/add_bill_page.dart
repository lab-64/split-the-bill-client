import 'package:flutter/material.dart';
import 'package:split_the_bill/models/bill.dart';

import '../../models/item.dart';
import '../../providers/dummy_data_calls.dart';

class AddBillPage extends StatefulWidget {
  const AddBillPage(this.dummyCalls, this.billID, {Key? key}) : super(key: key);

  final DummyDataCalls dummyCalls;
  final int billID;

  @override
  State<AddBillPage> createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  late Bill bill;

  @override
  void initState() {
    super.initState();
    bill = widget.dummyCalls.getBill(widget.billID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                onChanged: (billName) => {bill.name = billName},
                decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.blue),
                  hintText: bill.name,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            DataTable(
              showCheckboxColumn: false,
              columns: const <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Items',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.white),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Cost',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.white),
                    ),
                  ),
                ),
              ],
              rows: buildAllRows(),
            ),
            FloatingActionButton(
              heroTag: 'add',
              onPressed: () => {navigateToAddItemPage()},
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              heroTag: 'saveAndExit',
              onPressed: () => saveBillAndExit(),
              child: const Icon(Icons.check),
            )
          ],
        )),
        bottomNavigationBar: BottomNavigationBar(
          //TODO make into separate widget?
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
        ));
  }

  ///Helper method to build rows of a table.
  List<DataRow> buildAllRows() {
    return bill.items.map((item) => buildRow(item)).toList();
  }

  ///Helper method to build a single row of the table.
  DataRow buildRow(Item item) {
    return DataRow(cells: [
      DataCell(
        Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Text(item.name),
          ),
        ),
      ),
      DataCell(
        Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Text(item.price.toString()),
          ),
        ),
      )
    ]);
  }

  navigateToAddItemPage() {}

  saveBillAndExit() {
    if (bill.id == -1) widget.dummyCalls.saveNewBill(bill);
    widget.dummyCalls.overwriteBill(bill);
    Navigator.pop(context); //TODO change to be part of navbar
  }
}
