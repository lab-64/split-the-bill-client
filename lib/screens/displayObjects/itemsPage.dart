import 'package:flutter/material.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Items Page",
          style: TextStyle(fontSize: 60),
        ),
      ),
    );
  }
}
