import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/presentation/bills/bill/item_tile.dart';

import '../../../domain/bill/item.dart';
import 'item_expanded_tile.dart';

class ItemsList extends StatefulWidget {
  const ItemsList({
    super.key,
    required this.scrollController,
    required this.bill,
    required this.userId,
  });

  final ScrollController scrollController;
  final Bill bill;
  final String userId;

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  late List<bool> expandedList;

  @override
  void initState() {
    expandedList = List.generate(widget.bill.items.length, (_) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          gapH16,
          ListView(
            controller: widget.scrollController,
            shrinkWrap: true,
            children: [
              for (var i = 0; i < widget.bill.items.length; i++) ...[
                ItemTile(
                  onTap: () => setState(() {
                    expandedList[i] = !expandedList[i];
                  }),
                  item: widget.bill.items[i],
                  balance: _calculateBalance(
                      widget.bill.items[i], widget.bill.owner.id),
                ),
                if (expandedList[i])
                  ItemExpandedTile(
                    item: widget.bill.items[i],
                    getBalance: () => _calculateBalance(
                        widget.bill.items[i], widget.bill.owner.id),
                  )
              ]
            ],
          ),
        ],
      ),
    );
  }

  double _calculateBalance(Item item, String ownerId) {
    final containsUser = item.contributors
        .map((user) => user.id)
        .toList()
        .contains(widget.userId);
    final numOfContributors = item.contributors.length;
    final isOwner = (ownerId == widget.userId);
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
}
