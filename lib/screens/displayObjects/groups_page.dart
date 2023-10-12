import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:split_the_bill/models/group.dart';
import 'package:split_the_bill/providers/dummy_data_calls.dart';
import 'package:split_the_bill/screens/addObject/add_group_page.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage(this.dummyCalls, {Key? key}) : super(key: key);
  final DummyDataCalls dummyCalls;

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  late List<Group> groups;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //TODO replace by actual call to server
    //initialize all groups
    groups = widget.dummyCalls.getAllGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
          onPressed: () => {navigateToGroupPage(context, -1)},
          child: const Icon(Icons.group_add)),
      body: Center(
          child: Column(
        children: [
          const SelectionContainer.disabled(
              child: Text(
            "Groups Page",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40, height: 5),
          )),
          DataTable(
            showCheckboxColumn: false,
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Name',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Balance',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
            rows: buildAllRows(),
          ),
        ],
      )),
    );
  }

  ///Helper method to build all table rows.
  List<DataRow> buildAllRows() => groups.map((row) => buildRow(row)).toList();

  ///Helper method to build a single table row.
  DataRow buildRow(Group cells, {bool isHeader = false}) {
    return DataRow(
        cells: [
          DataCell(
            Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Text(cells.name),
              ),
            ),
          ),
          DataCell(
            Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Text(cells.userBalance.toString()),
              ),
            ),
          )
        ],
        onSelectChanged: (bool? values) =>
            {navigateToGroupPage(context, cells.id)});
  }

  ///Method to navigate to the GroupPage of a single group. Updates navbar.
  void navigateToGroupPage(BuildContext context, int id) async {
    print("before push ${groups.length}");
    await PersistentNavBarNavigator.pushNewScreen(context,
        screen: AddGroupPage(widget.dummyCalls, id));
    setState(() {
      groups = widget.dummyCalls.getAllGroups();
    });
    print("after push ${groups.length}");
  }
}
