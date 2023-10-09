import 'package:flutter/material.dart';
import 'package:split_the_bill/models/bill_mapping.dart';
import 'package:split_the_bill/models/group.dart';
import 'package:split_the_bill/providers/dummy_data_calls.dart';
import 'package:split_the_bill/screens/addObject/add_bill_page.dart';
import 'package:split_the_bill/screens/addObject/add_member_page.dart';

import '../../models/user.dart';

class GroupPage extends StatefulWidget {
  const GroupPage(this.groupID, this.dummyCalls, this.changeIndex, {Key? key})
      : super(key: key);

  final int groupID;
  final DummyDataCalls dummyCalls;
  final Function changeIndex;

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  bool membersMode = false;
  late Group group;

  @override
  void initState() {
    super.initState();
    group = widget.dummyCalls.getGroup(widget.groupID);
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
            child: TextFormField(
              initialValue: group.name,
              onChanged: (grpName) => {group.name = grpName},
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.blue),
                hintText: group.name,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          DataTable(
            showCheckboxColumn: false,
            columns: <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: InkWell(
                    onTap: () => setState(() => membersMode = false),
                    child: Text(
                      'Bills',
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
            onPressed: () {
              if (membersMode) {
                navigateToAddMember(context);
              } else {
                navigateToAddBill(context);
              }
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: 'bt2',
            onPressed: () => saveGroupAndExit(),
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
      ),
    );
  }

  /// Method to navigate to the bills page. It cleans up the Stack upon closing the bills page.
  Future<void> navigateToAddBill(BuildContext context) async {
    final res = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddBillPage(widget.changeIndex, widget.dummyCalls, -1, group.id)));
    setState(() {
      group = widget.dummyCalls.getGroup(widget.groupID);
    });
  }

  Future<void> navigateToAddMember(BuildContext context) async {
    final res = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddMemberPage(widget.dummyCalls)));
    //TODO remove and replace with actual member add page
    User test = User(99, "Test user", "test@test.de");
    setState(() {
      group.members.add(test);
    });
  }

  Future<void> navigateToEditBill(BuildContext context, int id) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddBillPage(widget.changeIndex, widget.dummyCalls, id, group.id)));
    setState(() {
      group = widget.dummyCalls.getGroup(widget.groupID);
    });
  }

  ///Saves the group locally and on the server. Exits the group page, cleans up stack itself.
  void saveGroupAndExit() {
    widget.dummyCalls.overwriteGroup(group);
    Navigator.pop(context); //TODO change to be part of navbar
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
              {navigateToEditBill(context, billMapping.bill.id)});
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
      ], onSelectChanged: (bool? values) => {print("not implemented yet")});//TODO change when members added
    }
  }
}
