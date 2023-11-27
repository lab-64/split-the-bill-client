import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/routes.dart';

// TODO: temporary solution, we will later use ShellRoute from GoRouter and make this widget stateless
// see: https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter/

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selectedIndex = 0;

  void handleDestinationSelected(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (index == 0) {
      context.goNamed(Routes.groups.name);
    } else if (index == 1) {
      context.goNamed(Routes.bills.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      child: NavigationBar(
        onDestinationSelected: handleDestinationSelected,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        indicatorColor: Colors.blue[400],
        selectedIndex: selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.group),
            label: 'Groups',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt),
            label: 'Bills',
          ),
        ],
      ),
    );
  }
}
