import 'package:flutter/material.dart';
import 'package:split_the_bill/models/group.dart';
import 'package:split_the_bill/providers/dummy_data_calls.dart';
import 'package:split_the_bill/screens/displayObjects/group_page.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage(this.changeIndex, this.dummyCalls, {Key? key}) : super(key: key);

  final Function changeIndex;
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
    groups = widget.dummyCalls.getAllGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DataTable(
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
        ),
      ),
    );
  }

  List<DataRow> buildAllRows() => groups.map((row) => buildRow(row)).toList();

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

  void navigateToGroupPage(BuildContext context, int id) async {
    final res = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => GroupPage(id, widget.dummyCalls, widget.changeIndex)));
    widget.changeIndex(res);
  }
}
