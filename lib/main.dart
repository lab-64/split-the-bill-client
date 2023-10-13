import 'package:flutter/material.dart';
import 'package:split_the_bill/providers/dummy_data_calls.dart';
import 'package:split_the_bill/screens/addObject/add_bill_page.dart';
import 'package:split_the_bill/screens/addObject/add_group_page.dart';
import 'package:split_the_bill/screens/addObject/add_item_page.dart';
import 'package:split_the_bill/screens/displayObjects/groups_page.dart';
import 'package:split_the_bill/widgets/navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DummyDataCalls dummyCalls = DummyDataCalls();
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/groups': (context) => GroupsPage(dummyCalls),
        '/addBill': (context) => AddBillPage(-1, -2, dummyCalls),
        '/addGroup': (context) => AddGroupPage(dummyCalls, -1),
        '/addItems': (context) => const AddItemPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(bottomNavigationBar: Navbar(dummyCalls)),
    );
  }
}
