import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';
import 'package:split_the_bill/presentation/groups/group/controllers.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/bills/bile_tile.dart';
import 'package:split_the_bill/routes.dart';

class BillsList extends ConsumerWidget {
  const BillsList(
      {super.key,
      required this.scrollController,
      this.groupId,
      this.showGroup = true});
  final ScrollController scrollController;
  final String? groupId;
  final bool showGroup;

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
            ListView(
              controller: scrollController,
              shrinkWrap: true,
              children: [
                for (final bill in bills)
                  BillTile(
                    bill: bill,
                    showGroup: showGroup,
                    onTap: () => {
                      context.goNamed(
                        GoRouterState.of(context).name == Routes.home.name
                            ? Routes.homeBill.name
                            : Routes.bill.name,
                        pathParameters: {'id': bill.id},
                      )
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
