import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/presentation/groups/group_item/controllers.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/bill/bill_list_tile.dart';

class GroupBillsSilverList extends ConsumerWidget {
  const GroupBillsSilverList(
      {super.key, required this.scrollController, required this.groupId});
  final ScrollController scrollController;
  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bills = ref.watch(groupBillsControllerProvider(groupId));

    return AsyncValueSliverWidget<List<Bill>>(
      value: bills,
      data: (bills) => SliverToBoxAdapter(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
              child: ListView(
                controller: scrollController,
                shrinkWrap: true,
                children: [
                  for (final bill in bills) BillListTile(bill: bill),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
