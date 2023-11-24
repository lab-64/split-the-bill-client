import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/domain/group/data/group_repository.dart';
import 'package:split_the_bill/presentation/bills/bills_sliver_list.dart';
import 'package:split_the_bill/presentation/shared/primary_button.dart';

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
        SliverToBoxAdapter(
          child: PrimaryButton(
            onPressed: () => ref
                .read(groupRepositoryProvider)
                .getGroup("2b4c3a3d-ceac-48b4-a635-5978157722b8"),
            text: 'Add New Group',
          ),
        ),
        BillsSliverList(scrollController: scrollController),
      ]),
    );
  }
}
