import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
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
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeText(
              text: 'Name: ${bill.name}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            gapH8,
            Text('Price: ${price.toCurrencyString()}'),
            gapH8,
            Text('Group: $groupName'),
            gapH8,
            Text('Date: ${DateFormat('dd.MM.yyyy').format(bill.date)}'),
            gapH16,
            Expanded(
                child: ElevatedButton(
              onPressed: () => UnseenBillRoute(billId: bill.id).push(context),
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.green, width: 2),
                // Green border
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Adjust the radius as needed
                ),
              ),
              child: const Text(
                'Split the Bill',
                style: TextStyle(color: Colors.green),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
