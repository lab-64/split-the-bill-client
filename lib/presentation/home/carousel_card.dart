import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/presentation/shared/components/primary_button.dart';
import 'package:split_the_bill/presentation/shared/extensions/currency_formatter.dart';

import '../../domain/bill/bill.dart';
import '../../router/routes.dart';
import '../shared/components/fade_text.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({super.key, required this.bill, required this.groupName});

  final Bill bill;
  final String groupName;

  @override
  Widget build(BuildContext context) {
    double price = bill.items.fold(0, (prev, item) => prev + item.price);
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                FadeText(
                  text: bill.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(price.toCurrencyString()),
              ],
            ),
            const Divider(),
            gapH8,
            Row(
              children: [
                const Icon(Icons.groups),
                gapW8,
                Text(groupName),
              ],
            ),
            gapH8,
            Row(
              children: [
                const Icon(Icons.calendar_today),
                gapW8,
                Text(DateFormat('dd.MM.yyyy').format(bill.date)),
              ],
            ),
            gapH8,
            Expanded(
              child: Center(
                child: PrimaryButton(
                  onPressed: () =>
                      UnseenBillRoute(billId: bill.id).push(context),
                  icon: Icons.receipt_long_rounded,
                  text: "Split!",
                  backgroundColor: Colors.green.shade400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
