import 'package:flutter/material.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/presentation/shared/bills/bill_tile.dart';
import 'package:split_the_bill/presentation/shared/components/date_label.dart';
import 'package:split_the_bill/presentation/shared/components/placeholder_display.dart';
import 'package:split_the_bill/router/routes.dart';

class BillsList extends StatelessWidget {
  const BillsList({
    super.key,
    required this.scrollController,
    required this.bills,
  });
  final ScrollController scrollController;
  final List<Bill> bills;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView(
          controller: scrollController,
          shrinkWrap: true,
          children: [
            if (bills.isEmpty)
              const Center(
                child: PlaceholderDisplay(
                  icon: Icons.receipt_long,
                  message: "No recent bills",
                ),
              ),
            for (int i = 0; i < bills.length; i++) ...[
              if (i == 0 || bills[i].date.day != bills[i - 1].date.day)
                DateLabel(date: bills[i].date),
              BillTile(
                bill: bills[i],
                onTap: () => BillRoute(billId: bills[i].id).push(context),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
