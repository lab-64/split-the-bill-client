import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation/shared/navigation/navbar.dart';
import 'package:split_the_bill/presentation/shared/navigation/navigation_bar_floating_button.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const NavbarFloatingButton(),
      bottomNavigationBar: const Navbar(),
      body: child,
    );
  }
}
