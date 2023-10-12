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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(dummyCalls, title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(this.dummyCalls, {super.key, required this.title});

  final DummyDataCalls dummyCalls;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: Navbar(widget.dummyCalls));
  }
}
