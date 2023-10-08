import 'package:flutter/material.dart';

import '../../models/bill_mapping.dart';
import '../../models/group.dart';
import '../../models/user.dart';
import '../../providers/dummy_data_calls.dart';
import 'add_bill_page.dart';

class AddGroupPage extends StatefulWidget {
  const AddGroupPage(this.changeIndex, this.dummyCalls, {Key? key})
      : super(key: key);

  final DummyDataCalls dummyCalls;
  final Function changeIndex;

  @override
  State<AddGroupPage> createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  bool membersMode = false;
  Group group = Group(-1, '', [], [], 0);
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: _nameKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter a group name'),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        group.name = value;
                        return null;
                      },
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
            onPressed: () => navigateToAddBill(context),
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: 'bt2',
            onPressed: () {
              if (_nameKey.currentState!.validate()) {
                saveGroupAndExit();
              }
            },
            child: const Icon(Icons.check),
          )
        ],
      )),
    );
  }

  Future<void> navigateToAddBill(BuildContext context) async {
    final res = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddBillPage(widget.dummyCalls, -1)));
    //TODO remove
    BillMapping test = BillMapping(widget.dummyCalls.users[0],
        widget.dummyCalls.bills[0], [widget.dummyCalls.users[0]]);
    setState(() {
      group.billMappings.add(test);
    });
  }

  void saveGroupAndExit() {
    widget.dummyCalls.saveNewGroup(group);
    widget.changeIndex(0);
  }

  List<DataRow> buildAllRows() {
    return membersMode
        ? group.members.map((member) => buildRow(null, member)).toList()
        : group.billMappings.map((bill) => buildRow(bill, null)).toList();
  }

  DataRow buildRow(BillMapping? billMapping, User? user) {
    if (!membersMode) {
      return DataRow(cells: [
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
      ]);
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
