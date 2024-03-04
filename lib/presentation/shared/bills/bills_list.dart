import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';
import 'package:split_the_bill/presentation/groups/group/controllers.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/bills/bill_tile.dart';
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
                for (int i = 0; i < bills.length; i++) ...[
                  if (i == 0 || bills[i].date.day != bills[i - 1].date.day)
                    DateLabel(date: bills[i].date),
                  BillTile(
                    bill: bills[i],
                    showGroup: showGroup,
                    onTap: () {
                      // TODO
                      final String currentLocation =
                          GoRouterState.of(context).name ?? "";

                      final String targetLocation;
                      final Map<String, String> pathParameters = {};
                      pathParameters['billId'] = bills[i].id;

                      if (currentLocation == NavbarRoutes.home.name) {
                        targetLocation = Routes.homeBill.name;
                      } else if (currentLocation == Routes.homeGroup.name) {
                        targetLocation = Routes.homeGroupBill.name;
                        pathParameters['groupId'] = bills[i].groupId;
                      } else {
                        targetLocation = Routes.bill.name;
                        pathParameters['groupId'] = bills[i].groupId;
                      }

                      context.goNamed(
                        targetLocation,
                        pathParameters: pathParameters,
                      );
                    },
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DateLabel extends StatelessWidget {
  final DateTime date;

  const DateLabel({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Sizes.p4),
      child: Text(
        DateFormat('dd. MMMM').format(date), // Customize the date format
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}
