import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation/groups/groups/add_new_group_button.dart';
import 'package:split_the_bill/presentation/groups/groups/groups_sliver_list.dart';

import 'groups_sliver_app_bar.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const GroupSliverAppBar(),
          const AddNewGroupButton(),
          GroupsSliverList(scrollController: scrollController),
        ],
      ),
    );
  }
}
