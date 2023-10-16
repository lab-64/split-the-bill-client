import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_the_bill/providers/dummy_authentication.dart';
import 'package:split_the_bill/providers/dummy_data_calls.dart';
import 'package:split_the_bill/screens/addObject/add_bill_page.dart';
import 'package:split_the_bill/screens/addObject/add_group_page.dart';
import 'package:split_the_bill/screens/addObject/add_item_page.dart';
import 'package:split_the_bill/screens/displayObjects/groups_page.dart';
import 'package:split_the_bill/screens/onboarding/login_page.dart';
import 'package:split_the_bill/screens/onboarding/register_page.dart';
import 'package:split_the_bill/widgets/navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = prefs.getString('username') != null;
  DummyDataCalls dummyCalls = DummyDataCalls();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/groups': (context) => GroupsPage(dummyCalls),
        '/addBill': (context) => AddBillPage(-1, -2, dummyCalls),
        '/addGroup': (context) => AddGroupPage(dummyCalls, -1),
        '/addItems': (context) => AddItemPage(dummyCalls, -1),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainApp(
        dummyCalls: dummyCalls,
        isLoggedIn: isLoggedIn,
      )));
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
    required this.dummyCalls,
    required this.isLoggedIn,
  });

  final DummyDataCalls dummyCalls;
  final bool isLoggedIn;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    checkIfLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Navbar(widget.dummyCalls),
      floatingActionButton: FloatingActionButton(
        heroTag: "logout",
        onPressed: () {
          DummyAuthentication.logout();
          PersistentNavBarNavigator.pushNewScreen(context,
              screen: const LoginPage());
        },
        child: const Icon(Icons.logout),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  void checkIfLoggedIn() async {
    if (!widget.isLoggedIn) {
      Future.delayed(Duration.zero, () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const LoginPage()));
      });
    }
  }
}
