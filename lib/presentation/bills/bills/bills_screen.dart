import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillsScreen extends ConsumerWidget {
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bills"),
      ),
      body: const CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Center(
            child: Text("Not implemented yet."),
          ),
        ),
        //BillsList(scrollController: scrollController),
      ]),
    );
  }
}
