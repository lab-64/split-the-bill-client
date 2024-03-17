import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/presentation/shared/navigation/navbar.dart';
import 'package:split_the_bill/routes.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed(
          Routes.newBillGroupSelection.name,
        ),
        backgroundColor: Colors.blue.shade400,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const Navbar(),
      body: child,
    );
  }
}
