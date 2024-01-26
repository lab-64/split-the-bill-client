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
      context.goNamed(Routes.home.name);
    } else if (index == 1) {
      context.goNamed(Routes.groups.name);
    } else if (index == 2) {
      context.goNamed(Routes.bills.name);
    } else if (index == 3) {
      context.goNamed(Routes.profile.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue.shade400,
      notchMargin: 6.0,
      elevation: 0,
      shape: CircularNotchedRectangle(),
      child: NavigationBar(
        onDestinationSelected: handleDestinationSelected,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: selectedIndex,
        backgroundColor: Colors.transparent,
        indicatorColor: Colors.white,
        elevation: 0,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home,
                color:
                    selectedIndex == 0 ? Colors.blue.shade400 : Colors.white),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.group,
                color:
                    selectedIndex == 1 ? Colors.blue.shade400 : Colors.white),
            label: 'Groups',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long,
                color:
                    selectedIndex == 2 ? Colors.blue.shade400 : Colors.white),
            label: 'Bills',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings,
                color:
                    selectedIndex == 3 ? Colors.blue.shade400 : Colors.white),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
