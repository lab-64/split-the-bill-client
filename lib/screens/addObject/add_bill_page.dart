import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:split_the_bill/models/bill.dart';
import 'package:split_the_bill/screens/addObject/add_item_page.dart';
import 'package:split_the_bill/widgets/popupNotification.dart';
import '../../models/item.dart';
import '../../providers/dummy_data_calls.dart';
import '../displayObjects/bills_page.dart';

class AddBillPage extends StatefulWidget {
  const AddBillPage(this.billID, this.groupID, this.dummyCalls, {Key? key})
      : super(key: key);

  final int billID;
  final int groupID;
  final DummyDataCalls dummyCalls;

  @override
  State<AddBillPage> createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  late Bill bill = widget.dummyCalls.getBill(widget.billID);
  late DateTime date = bill.date;
  late String dateString = date.toLocal().toString().split(' ')[0];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    Icon icon = const Icon(Icons.check);

    return Scaffold(
      key: ValueKey<int>(count),
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
          Popup(saveBillAndExit, icon),
        ],
      )),
    );
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

  ///Helper method to navigate to addItemPage and update variables accordingly.
  navigateToAddItemPage() async {
    final res = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const AddItemPage()));
    //TODO remove and replace with actual item add page
    Item item = Item(45, "Test Item", 4);
    setState(() {
      bill.items.add(item);
    });
  }

  ///Method to save the bill and return to the correct screen.
  saveBillAndExit() {
    print("saving");
    if (bill.id < 0) {
      widget.dummyCalls.saveNewBill(bill);
      print("save new bill");
    } else {
      widget.dummyCalls.overwriteBill(bill);
      print("overwrite bill");
    }

    if (widget.groupID == -1) {
      //return values to new group
      Navigator.pop(context, bill);
    } else if (widget.groupID > 0) {
      //update values in existing group
      widget.dummyCalls.updateBillInGroup(bill.id, widget.groupID);
      Navigator.pop(context);
    } else {
      setState(() {
        //reset screen
        bill = widget.dummyCalls.getBill(widget.billID);
        date = bill.date;
        dateString = date.toLocal().toString().split(' ')[0];
        ++count;
      });
    }
  }
}
