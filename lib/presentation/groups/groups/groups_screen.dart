import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation/groups/groups/add_new_group_button.dart';

import 'groups_silver_app_bar.dart';
import 'groups_silver_list.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const GroupSilverAppBar(),
          const AddNewGroupButton(),
          GroupsSilverList(scrollController: scrollController),
        ],
      ),
    );
  }
}
