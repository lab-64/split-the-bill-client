import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:split_the_bill/models/group.dart';
import 'package:split_the_bill/providers/dummy_data_calls.dart';
import 'package:split_the_bill/screens/add_object/add_group_page.dart';
import 'package:split_the_bill/widgets/screen_title.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key, required this.dummyCalls}) : super(key: key);
  final DummyDataCalls dummyCalls;

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  late List<Group> groups = widget.dummyCalls.getAllGroups();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const ScreenTitle(text: "Groups Page"),
          buildDataTable(),
        ],
      )),
      floatingActionButton: buildNavigateToAddGroupsPageButton(context),
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
    await PersistentNavBarNavigator.pushNewScreen(context,
        screen: AddGroupPage(dummyCalls: widget.dummyCalls, id: id));
    setState(() {
      groups = widget.dummyCalls.getAllGroups();
    });
  }

  DataTable buildDataTable() {
    return DataTable(
      showCheckboxColumn: false,
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Name',
              style: TextStyle(
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Balance',
              style: TextStyle(
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
      rows: buildAllRows(),
    );
  }

  FloatingActionButton buildNavigateToAddGroupsPageButton(
      BuildContext context) {
    return FloatingActionButton(
        heroTag: 'navigateToAddGroupPage',
        onPressed: () => {navigateToGroupPage(context, -1)},
        child: const Icon(Icons.group_add));
  }
}
