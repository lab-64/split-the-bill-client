import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/item.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/extensions/currency_formatter.dart';

class ItemsList extends ConsumerWidget {
  const ItemsList({
    super.key,
    required this.userId,
    required this.bill,
  });

  final String userId;
  final Bill bill;

  double _calculateBalance(Item item, String ownerId) {
    final containsUser =
        item.contributors.map((user) => user.id).toList().contains(userId);
    final numOfContributors = item.contributors.length;
    final isOwner = (ownerId == userId);
    final isContributorsEmpty = item.contributors.isEmpty;

    if (isOwner) {
      if (containsUser) {
        return item.price * ((numOfContributors - 1) / numOfContributors);
      } else if (isContributorsEmpty) {
        return 0.00;
      } else {
        return item.price;
      }
    } else if (containsUser) {
      return (item.price / numOfContributors) * -1;
    } else {
      return 0.00;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupStateProvider(bill.groupId));

    return AsyncValueWidget(
      value: group,
      data: (group) => Column(
        children: [
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (final item in bill.items)
                ItemRow(
                  item: item,
                  balance: _calculateBalance(item, bill.owner.id),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  const ItemRow({super.key, required this.item, required this.balance});

  final Item item;
  final double balance;

  @override
  Widget build(BuildContext context) {
    Color color;
    if (balance > 0) {
      color = Colors.green;
    } else if (balance < 0) {
      color = Colors.red;
    } else {
      color = Colors.black;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.p4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.name,
                  style: const TextStyle(fontSize: 16),
                  maxLines: 1,
                ),
              ),
              Text(
                item.price.toCurrencyString(),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 16,
                  ),
                  gapW4,
                  Text(item.contributors.length.toString()),
                ],
              ),
              Text(
                balance.toCurrencyString(),
                style: TextStyle(
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
