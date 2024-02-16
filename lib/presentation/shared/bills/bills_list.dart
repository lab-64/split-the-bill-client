import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';
import 'package:split_the_bill/presentation/groups/group/controllers.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/bills/bill_list_tile.dart';

class BillsList extends ConsumerWidget {
  const BillsList({super.key, required this.scrollController, this.groupId});
  final ScrollController scrollController;
  final String? groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bills = groupId != null
        ? ref.watch(groupBillsControllerProvider(groupId!))
        : ref.watch(billsStateProvider);

    return AsyncValueSliverWidget(
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
