import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/presentation/bills/bill/controllers.dart';
import 'package:split_the_bill/presentation/shared/item/item_list_tile.dart';

import '../../../constants/app_sizes.dart';
import '../../../domain/item/item.dart';
import '../../shared/async_value_widget.dart';

class BillItemSliverList extends ConsumerWidget {
  const BillItemSliverList(
      {super.key, required this.scrollController, required this.billId});

  final ScrollController scrollController;
  final String billId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(billItemsControllerProvider(billId));


    return AsyncValueSliverWidget<List<Item>>(
      value: items,
      data: (items) => SliverToBoxAdapter(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
              child: ListView(
                controller: scrollController,
                shrinkWrap: true,
                children: [
                  for (final item in items) ItemListTile(item: item),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
