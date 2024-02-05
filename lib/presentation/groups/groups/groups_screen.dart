import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/presentation/shared/groups/groups_list.dart';
import 'package:split_the_bill/routes.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Groups"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(Sizes.p8),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => context.goNamed(
                Routes.newGroup.name,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
        child: CustomScrollView(
          slivers: [
            GroupsList(scrollController: scrollController),
          ],
        ),
      ),
    );
  }
}
