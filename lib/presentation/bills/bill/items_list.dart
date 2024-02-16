import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/presentation/bills/bill/item_tile.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({
    super.key,
    required this.scrollController,
    required this.bill,
  });

  final ScrollController scrollController;
  final AsyncValue<Bill> bill;

  @override
  Widget build(BuildContext context) {
    return AsyncValueSliverWidget(
      value: bill,
      data: (bill) => SliverToBoxAdapter(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
              child: ListView(
                controller: scrollController,
                shrinkWrap: true,
                children: [
                  for (final item in bill.items) ItemTile(item: item),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
