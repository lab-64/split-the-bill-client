import 'package:flutter/material.dart';
import 'package:split_the_bill/models/bill.dart';
import 'package:split_the_bill/models/group.dart';
import 'package:split_the_bill/screens/addObject/add_item_page.dart';

import '../../models/item.dart';
import '../../providers/dummy_data_calls.dart';

class AddBillPage extends StatefulWidget {
  const AddBillPage(
      this.changeIndex, this.dummyCalls, this.billID, this.groupID,
      {Key? key})
      : super(key: key);

  final DummyDataCalls dummyCalls;
  final int billID;
  final int groupID;
  final Function changeIndex;

  @override
  State<AddBillPage> createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  late Bill bill = widget.dummyCalls.getBill(widget.billID);
  late DateTime date = bill.date;
  late String dateString = date.toLocal().toString().split(' ')[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SelectionContainer.disabled(
                child: Text(
              "Bill Page",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40, height: 5),
            )),
            SizedBox(
              width: 200,
              child: TextFormField(
                initialValue: bill.name,
                onChanged: (billName) => {bill.name = billName},
                decoration: InputDecoration(
                  hintStyle: const TextStyle(color: Colors.blue),
                  hintText: bill.name,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            Center(
              child: Text(
                "Date: $dateString",
                style: const TextStyle(height: 3),
              ),
            ),
            ElevatedButton(
                onPressed: () => selectDate(context),
                child: const Text("Select Date")),
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

  ///Helper method to select the date and update according variables.
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
      });
      bill.date = date;
    }
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

  navigateToAddItemPage() async {
    final res = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const AddItemPage()));
    //TODO remove and replace with actual item add page
    Item item = Item(45, "Test Item", 4);
    setState(() {
      bill.items.add(item);
    });
  }

  saveBillAndExit() {
    if (bill.id == -1) {
      widget.dummyCalls.saveNewBill(bill);
      widget.dummyCalls.addBillToGroup(bill.id, widget.groupID);
      print("here i am");
      widget.changeIndex(0);
    } else {
      widget.dummyCalls.overwriteBill(bill);
      if (widget.groupID >= 0) {
        widget.dummyCalls.updateBillInGroup(bill.id, widget.groupID);
      }
      print("once again");
      Navigator.pop(context); //TODO change to be part of navbar
    }
  }
}
