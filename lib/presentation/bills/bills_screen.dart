import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/presentation/bills/bills_silver_list.dart';

class BillsScreen extends ConsumerWidget {
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bills"),
      ),
      body: CustomScrollView(slivers: [
        BillsSilverList(scrollController: scrollController),
      ]),
    );
  }
}
