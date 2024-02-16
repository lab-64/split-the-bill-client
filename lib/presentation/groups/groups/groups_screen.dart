import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation/groups/groups/add_new_group_button.dart';
import 'package:split_the_bill/presentation/groups/groups/groups_list.dart';

import 'app_bar/groups_app_bar.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const GroupsAppBar(),
          const AddNewGroupButton(),
          GroupsList(scrollController: scrollController),
        ],
      ),
    );
  }
}
