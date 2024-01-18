import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/presentation/groups/groups/add_new_group_button.dart';
import 'package:split_the_bill/presentation/groups/groups/balance_card.dart';
import 'package:split_the_bill/presentation/groups/groups/groups_list.dart';
import 'package:split_the_bill/presentation/groups/groups/headline.dart';

import 'app_bar/groups_app_bar.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
          child: CustomScrollView(
            slivers: [
              const GroupsAppBar(),
              const SliverToBoxAdapter(child: gapH24),
              const BalanceCard(),
              const SliverToBoxAdapter(child: gapH24),
              //const AddNewGroupButton(),
              const SliverToBoxAdapter(child: Headline(title: "My Groups")),
              const SliverToBoxAdapter(child: gapH8),
              GroupsList(scrollController: scrollController),
              const SliverToBoxAdapter(child: gapH8),
              const SliverToBoxAdapter(child: Headline(title: "Recent Bills")),
            ],
          ),
        ),
      ),
    );
  }
}
