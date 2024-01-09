import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation/shared/bill/item_list_screen.dart';

class NewBillScreen extends StatefulWidget {
  const NewBillScreen({super.key});

  @override
  State<NewBillScreen> createState() => _NewBillScreenState();
}

class _NewBillScreenState extends State<NewBillScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Bill"),
      ),
      body: const ItemListScreen(
        isNewBill: false,
        existingItems: [],
      ),
    );
  }
}
