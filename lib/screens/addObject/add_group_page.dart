import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:split_the_bill/models/bill.dart';
import 'package:split_the_bill/screens/displayObjects/groups_page.dart';

import '../../models/bill_mapping.dart';
import '../../models/group.dart';
import '../../models/user.dart';
import '../../providers/dummy_data_calls.dart';
import 'add_bill_page.dart';

class AddGroupPage extends StatefulWidget {
  const AddGroupPage(this.dummyCalls, this.id, {Key? key}) : super(key: key);

  final DummyDataCalls dummyCalls;
  final int id;

  @override
  State<AddGroupPage> createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  bool membersMode = false;
  late Group group = widget.id < 0
      ? Group(-1, '', [], [], 0)
      : DummyDataCalls().getGroup(widget.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SelectionContainer.disabled(
              child: Text(
            "Add Group Page",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40, height: 5),
          )),
          Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter a group name'),
                      initialValue: group.name,
                    ),
                  ],
                ),
              )),
          DataTable(
            showCheckboxColumn: false,
            columns: <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: InkWell(
                    onTap: () => setState(() {
                      membersMode = false;
                    }),
                    child: Text(
                      'Items',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          backgroundColor:
                              membersMode ? Colors.white : Colors.blue),
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: InkWell(
                    onTap: () => setState(() {
                      membersMode = true;
                    }),
                    child: Text(
                      'Members',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          backgroundColor:
                              membersMode ? Colors.blue : Colors.white),
                    ),
                  ),
                ),
              ),
            ],
            rows: buildAllRows(),
          ),
          FloatingActionButton(
            heroTag: 'bt1',
            onPressed: () => navigateToAddBill(context, -1),
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: 'bt2',
            onPressed: () => saveGroupAndExit(),
            child: const Icon(Icons.check),
          )
        ],
      )),
    );
  }

  ///Helper method to navigate to addBillPage and update variables accordingly.
  Future<void> navigateToAddBill(BuildContext context, int billID) async {
    final res = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => billID == -1
            ? AddBillPage(-1, group.id, widget.dummyCalls)
            : AddBillPage(billID, group.id, widget.dummyCalls)));
    print(res);
    //TODO remove
    BillMapping test = BillMapping(
        widget.dummyCalls.users[0], res as Bill, [widget.dummyCalls.users[0]]);
    setState(() {
      group.billMappings.add(test);
    });
  }

  ///Method to save the group and return to the correct screen.
  void saveGroupAndExit() {
    //TODO do not save new if not new
    if (group.name == '') group.name = "new Group";
    widget.dummyCalls.saveNewGroup(group);
    Navigator.pop(context);
  }

  ///Helper method to build rows of a table.
  List<DataRow> buildAllRows() {
    return membersMode
        ? group.members.map((member) => buildRow(null, member)).toList()
        : group.billMappings.map((bill) => buildRow(bill, null)).toList();
  }

  ///Helper method to build a single row of the table.
  DataRow buildRow(BillMapping? billMapping, User? user) {
    if (!membersMode) {
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
                  child: Text(billMapping.bill.price.toString()),
                ),
              ),
            )
          ],
          onSelectChanged: (bool? values) =>
              {navigateToAddBill(context, billMapping.bill.id)});
    } else {
      return DataRow(cells: [
        DataCell(
          Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Text(user!.username),
            ),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Text(user.email),
            ),
          ),
        )
      ]);
    }
  }
}
