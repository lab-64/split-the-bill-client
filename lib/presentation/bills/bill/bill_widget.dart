import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/presentation/bills/bill/items_list.dart';
import 'package:split_the_bill/presentation/shared/extensions/currency_formatter.dart';
import 'package:split_the_bill/presentation/shared/profile/profile_image.dart';

class BillWidget extends StatelessWidget {
  const BillWidget({super.key, required this.bill, required this.userId});

  final Bill bill;
  final String userId;

  String parseDateToString(DateTime date) {
    final dateFormat = DateFormat("d. MMMM yyyy");
    return dateFormat.format(date);
  }

  @override
  Widget build(BuildContext context) {
    final billTotalPrice =
        bill.items.fold(0.0, (prev, item) => prev + item.price);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: Sizes.p16),
      padding: const EdgeInsets.all(Sizes.p24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Sizes.p16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(Sizes.p16),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Icon(Icons.receipt_long, size: 32),
                    Text(
                      textAlign: TextAlign.center,
                      bill.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      parseDateToString(bill.date),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          gapH20,
          const Text(
            'Items',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          ItemsList(userId: userId, bill: bill),
          const Divider(),
          BillFooter(
            bill: bill,
            userBalance: bill.balance[userId] ?? 0,
            billTotalPrice: billTotalPrice,
          ),
        ],
      ),
    );
  }
}

class BillFooter extends StatelessWidget {
  const BillFooter({
    super.key,
    required this.bill,
    required this.userBalance,
    required this.billTotalPrice,
  });

  final Bill bill;
  final double userBalance;
  final double billTotalPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.p4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Paid by',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Row(
                children: [
                  ProfileImage(user: bill.owner, size: 10),
                  gapW4,
                  Text(
                    bill.owner.getDisplayName().length > 7
                        ? '${bill.owner.getDisplayName().substring(0, 7)}...'
                        : bill.owner.getDisplayName(),
                    maxLines: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.p4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userBalance > 0 ? 'You are owed' : 'You owe',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                userBalance.toCurrencyString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: userBalance > 0 ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.p4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                billTotalPrice.toCurrencyString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
