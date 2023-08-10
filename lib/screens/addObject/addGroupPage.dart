import 'package:flutter/material.dart';

class AddGroupPage extends StatefulWidget {
  const AddGroupPage({Key? key}) : super(key: key);

  @override
  State<AddGroupPage> createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Add Group Page",
          style: TextStyle(fontSize: 60),
        ),
      ),
    );
  }
}
