import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/presentation/bills/bill/item_tile.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';

import '../../../domain/bill/item.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({
    super.key,
    required this.scrollController,
    required this.bill,
    required this.userId,
  });

  final ScrollController scrollController;
  final AsyncValue<Bill> bill;
  final String userId;

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
  Widget build(BuildContext context) {
    return AsyncValueSliverWidget(
      value: bill,
      data: (bill) => SliverToBoxAdapter(
        child: Column(
          children: [
            gapH16,
            ListView(
              controller: scrollController,
              shrinkWrap: true,
              children: [
                for (final item in bill.items)
                  ItemTile(
                    item: item,
                    balance: _calculateBalance(item, bill.owner.id),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
