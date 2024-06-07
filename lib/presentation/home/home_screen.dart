import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';
import 'package:split_the_bill/presentation/home/home_app_bar.dart';
import 'package:split_the_bill/presentation/home/home_balance_card.dart';
import 'package:split_the_bill/presentation/home/home_bill_carousel.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/headline.dart';
import 'package:split_the_bill/presentation/shared/groups/groups_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    final newBills = ref.watch(billsStateProvider(isUnseen: true));
    final groups = ref.watch(groupsStateProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
          child: RefreshIndicator(
            onRefresh: () => ref.refresh(groupsStateProvider.future).then(
                (_) => ref.refresh(billsStateProvider(isUnseen: true).future)),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: HomeAppBar()),
                const SliverToBoxAdapter(child: gapH24),
                const SliverToBoxAdapter(child: HomeBalanceCard()),
                const SliverToBoxAdapter(child: gapH24),
                AsyncValueSliverWidget(
                  value: newBills,
                  data: (newBills) {
                    if (newBills.isNotEmpty) {
                      return AsyncValueSliverWidget(
                        value: groups,
                        data: (groups) => SliverToBoxAdapter(
                            child: HomeBillCarousel(
                                bills: newBills, groups: groups)),
                      );
                    }
                    return const SliverToBoxAdapter(child: SizedBox());
                  },
                ),
                const SliverToBoxAdapter(child: gapH24),
                const SliverToBoxAdapter(child: Headline(title: "My Groups")),
                GroupsList(scrollController: scrollController),
                const SliverToBoxAdapter(child: gapH8),
                const SliverToBoxAdapter(child: gapH32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
