import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';
import 'package:split_the_bill/presentation/shared/navigation/expandable_action_button.dart';
import 'package:split_the_bill/router/routes.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          ActionButton(
            icon: Icons.photo_camera,
            onPressed: () => const CameraRoute().push(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavigationBar(),
      body: child,
    );
  }
}

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({super.key});

  int getSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    final String homeRoute = const HomeRoute().location;
    final String groupsRoute = const GroupsRoute().location;
    final String billsRoute = const BillsRoute().location;
    final String profileRoute = const ProfileRoute().location;

    if (location == homeRoute) {
      return 0;
    } else if (location == groupsRoute) {
      return 1;
    } else if (location == billsRoute) {
      return 2;
    } else if (location == profileRoute) {
      return 3;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = getSelectedIndex(context);

    return BottomAppBar(
      color: Colors.blue.shade400,
      notchMargin: 4.0,
      elevation: 0,
      shape: const CircularNotchedRectangle(),
      child: NavigationBar(
        onDestinationSelected: (int index) {
          switch (index) {
            case 0:
              const HomeRoute().go(context);
            case 1:
              const GroupsRoute().go(context);
            case 2:
              const BillsRoute().go(context);
            case 3:
              const ProfileRoute().go(context);
          }
        },
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
            icon: Icon(Icons.groups,
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
            icon: Icon(Icons.person,
                color:
                    selectedIndex == 3 ? Colors.blue.shade400 : Colors.white),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
