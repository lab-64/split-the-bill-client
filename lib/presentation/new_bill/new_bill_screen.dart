import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/presentation/shared/bill/bill_bar.dart';
import 'package:split_the_bill/presentation/shared/bill/item_list_controller.dart';
import 'package:split_the_bill/presentation/shared/bill/item_list_screen.dart';
import 'package:split_the_bill/presentation/shared/primary_button.dart';

import 'item_container.dart';

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
