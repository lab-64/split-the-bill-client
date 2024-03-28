import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/presentation/shared/navigation/controllers.dart';
import 'package:split_the_bill/routes.dart';

class Navbar extends ConsumerWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(navbarControllerProvider);

    return BottomAppBar(
      color: Colors.blue.shade400,
      notchMargin: 4.0,
      elevation: 0,
      shape: const CircularNotchedRectangle(),
      child: NavigationBar(
        onDestinationSelected: (index) =>
            handleDestinationSelected(context, ref, index),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: index,
        backgroundColor: Colors.transparent,
        indicatorColor: Colors.white,
        elevation: 0,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home,
                color: index == 0 ? Colors.blue.shade400 : Colors.white),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups,
                color: index == 1 ? Colors.blue.shade400 : Colors.white),
            label: 'Groups',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long,
                color: index == 2 ? Colors.blue.shade400 : Colors.white),
            label: 'Bills',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings,
                color: index == 3 ? Colors.blue.shade400 : Colors.white),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void handleDestinationSelected(
    BuildContext context,
    WidgetRef ref,
    int index,
  ) {
    ref.read(navbarControllerProvider.notifier).setIndex(index);
    context.goNamed(NavbarRoutes.values[index].name);
  }
}
