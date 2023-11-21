import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/routes.dart';

class NavbarFloatingButton extends StatelessWidget {
  const NavbarFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      shape: const CircleBorder(),
      onPressed: () {
        context.pushNamed(Routes.newBill.name);
      },
      child: const Icon(Icons.add),
    );
  }
}
