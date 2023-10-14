import 'package:flutter/material.dart';
import 'package:split_the_bill/models/bill.dart';
import 'package:split_the_bill/screens/addObject/add_item_page.dart';
import 'package:split_the_bill/widgets/addBillToGroupPopup.dart';
import 'package:split_the_bill/widgets/saveBillPopup.dart';
import 'package:split_the_bill/widgets/screenTitle.dart';

import '../../models/item.dart';
import '../../providers/dummy_data_calls.dart';

class AddBillPage extends StatefulWidget {
  ///The parameter [billID] should have a value of -1 if a new Bill is created, a value
  ///of 0 or higher if an existing bill is opened. The parameter [groupID] should have
  ///a value of -2 if a Bill is created/changed without a group, -1 if a bill is
  ///created/changed with a non saved group and 0 if a bill is created/changed with an existing group.
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
  int newGroupID = -1;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    Icon addBillIcon = const Icon(Icons.check);
    Icon addToGroupIcon = const Icon(Icons.group_add);

    return Scaffold(
      key: ValueKey<int>(count),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ScreenTitle(text: "Add Bill Page"),
          BillNameFormField(bill: bill),
          buildDateSelection(context, addToGroupIcon),
          SaveBillPopup(saveBillAndExit, addBillIcon),
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
    ], onSelectChanged: (bool? value) => {navigateToAddItemPage(item.id)});
  }

  ///Helper method to navigate to addItemPage and update variables accordingly.
  navigateToAddItemPage(int itemID) async {
    final res = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddItemPage(widget.dummyCalls, itemID)));
    setState(() {
      if (res != null) {
        if (res is Item) bill.items.add(res);
        else widget.dummyCalls.deleteItem(res);
      }
    });
  }

  ///Method to save the bill and return to the correct screen.
  saveBillAndExit() {
    //save as a new bill
    if (widget.billID < 0)
      widget.dummyCalls.saveNewBill(bill);
    //overwrite exiting bill
    else
      widget.dummyCalls.overwriteBill(bill);

    //already part of a group
    if (widget.groupID > 0) {
      if (widget.billID >= 0) {
        //change group
        if (newGroupID >= 0)
          widget.dummyCalls
              .changeBillFromTo(bill.id, widget.groupID, newGroupID);
        //no change
        else
          widget.dummyCalls.updateBillInGroup(bill.id, widget.groupID);

        Navigator.pop(context);
      } else
        Navigator.pop(context, bill);
    }
    //part of a group, which is not saved yet
    else if (widget.groupID == -1) {
      if (widget.billID == -1)
        Navigator.pop(context, bill);
      else
        Navigator.pop(context);
    }
    //not part of any group
    else {
      //add new bill to a group
      if (newGroupID >= 0)
        widget.dummyCalls.addBillToGroup(bill.id, newGroupID);

      setState(() {
        //reset screen
        bill = widget.dummyCalls.getBill(widget.billID);
        date = bill.date;
        ++count;
      });
    }
  }

  Column buildDateSelection(BuildContext context, Icon addToGroupIcon) {
    return Column(
      children: [
        Center(
          child: Text(
            "Date: ${date.day}.${date.month}.${date.year}",
            style: const TextStyle(height: 3),
          ),
        ),
        ElevatedButton(
            onPressed: () => selectDate(context),
            child: const Text("Select Date")),
        buildDataTable(),
        FloatingActionButton(
          heroTag: 'navigateToAddItemPage',
          onPressed: () => {navigateToAddItemPage(-1)},
          child: const Icon(Icons.add),
        ),
        Visibility(
            visible: widget.groupID == -2 || widget.billID != -1,
            child: AddBillToGroupPopup(
                widget.dummyCalls, addToGroup, addToGroupIcon)),
      ],
    );
  }

  DataTable buildDataTable() {
    return DataTable(
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
    );
  }

  void addToGroup(int groupID) {
    newGroupID = groupID;
  }
}

class BillNameFormField extends StatelessWidget {
  const BillNameFormField({
    super.key,
    required this.bill,
  });

  final Bill bill;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
