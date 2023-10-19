import 'package:flutter/material.dart';
import 'package:split_the_bill/models/bill.dart';
import 'package:split_the_bill/widgets/screen_title.dart';

import '../../models/bill_mapping.dart';
import '../../models/group.dart';
import '../../models/user.dart';
import '../../providers/dummy_data_calls.dart';
import 'add_bill_page.dart';

class AddGroupPage extends StatefulWidget {
  ///The parameter [id] should have a value of -1 if it is a new group and any
  ///value of 0 or higher if it already exists.
  const AddGroupPage({Key? key, required this.dummyCalls, required this.id})
      : super(key: key);

  final DummyDataCalls dummyCalls;
  final int id;

  @override
  State<AddGroupPage> createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  bool membersMode = false;
  late Group group = widget.id < 0
      ? Group(-1, '', [], [], 0)
      : widget.dummyCalls.getGroup(widget.id); //create new group if id < 0

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ScreenTitle(text: "Add Group Page"),
          GroupNameFormField(group: group),
          buildDataTable(),
          buildNavigateToAddBIllButton(context),
          buildSaveGroupAndExitButton()
        ],
      )),
    );
  }

  ///Method to save the group and return to the correct screen.
  void saveGroupAndExit() {
    //new group
    if (group.id == -1) {
      //no group name set
      if (group.name == '') {
        group.name = "new Group";
      }
      widget.dummyCalls.saveNewGroup(group);
    }
    //existing group
    else {
      widget.dummyCalls.overwriteGroup(group);
    }
    Navigator.pop(context);
  }

  ///Helper method to navigate to addBillPage and update variables accordingly.
  Future<void> navigateToAddBill(BuildContext context, int billId) async {
    final res = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddBillPage(
            billId: billId, groupId: group.id, dummyCalls: widget.dummyCalls)));
    //add to current group, which isn't saved yet
    if (res != null) {
      print("new bill");
      BillMapping test = BillMapping(widget.dummyCalls.users[0], res as Bill,
          [widget.dummyCalls.users[0]]);
      setState(() {
        group.billMappings.add(test);
      });
    }
    //add to existing current group
    else {
      setState(() {
        group = widget.dummyCalls.getGroup(group.id);
      });
    }
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
                  child: Text(billMapping.bill.getTotalPrice().toString()),
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

  FloatingActionButton buildSaveGroupAndExitButton() {
    return FloatingActionButton(
      heroTag: 'saveGroupAndExit',
      onPressed: () => saveGroupAndExit(),
      child: const Icon(Icons.check),
    );
  }

  FloatingActionButton buildNavigateToAddBIllButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'navigateToAddBIll',
      onPressed: () => navigateToAddBill(context, -1),
      child: const Icon(Icons.add),
    );
  }

  DataTable buildDataTable() {
    return DataTable(
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
                    backgroundColor: membersMode ? Colors.white : Colors.blue),
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
                    backgroundColor: membersMode ? Colors.blue : Colors.white),
              ),
            ),
          ),
        ),
      ],
      rows: buildAllRows(),
    );
  }
}

class GroupNameFormField extends StatelessWidget {
  const GroupNameFormField({
    super.key,
    required this.group,
  });

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a group name'),
                onChanged: (value) => {group.name = value},
                initialValue: group.name,
              ),
            ],
          ),
        ));
  }
}
