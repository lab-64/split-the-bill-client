import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/presentation/bills/unseen_bill/controllers.dart';
import 'package:split_the_bill/presentation/bills/unseen_bill/item_contribution.dart';
import 'package:split_the_bill/presentation/shared/components/ellipse_text.dart';

import '../../../constants/app_sizes.dart';
import '../../../domain/bill/bill.dart';
import '../../../domain/bill/item.dart';

class BillContribution extends ConsumerStatefulWidget {
  const BillContribution({
    super.key,
    required this.bill,
  });

  final Bill bill;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BillContributionState();
}

class _BillContributionState extends ConsumerState<BillContribution> {
  late List<Item> items;
  late List<bool> expandedItems;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    items = List.from(widget.bill.items);
    expandedItems = List.generate(items.length, (index) => index == 0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p24),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: items.length,
              itemBuilder: (context, index) {
                if (index < items.length) {
                  return ItemContributionDecoration(
                    borderColor:
                        expandedItems[index] ? Colors.grey : Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () => {
                            setState(() {
                              expandedItems[index] = !expandedItems[index];
                            })
                          },
                          leading: const Icon(
                            Icons.inventory,
                            color: Colors.blue,
                          ),
                          title: EllipseText(
                            text: items[index].name,
                            size: Sizes.p64,
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          trailing: _isContributing(items[index])
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                        ),
                        if (expandedItems[index]) ...[
                          const Divider(),
                          ItemContribution(
                            changeContribution: _setContribution,
                            item: items[index],
                            index: index,
                          )
                        ],
                      ],
                    ),
                  );
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _isContributing(Item item) {
    final user = ref.watch(authStateProvider).requireValue;

    return items.any(
      (e) => e.id == item.id && e.contributors.any((e) => e.id == user.id),
    );
  }

  void _setContribution(bool isContributing, int index) async {
    final user = ref.watch(authStateProvider).requireValue;
    final item = items[index];

    setState(() {
      expandedItems =
          List.generate(expandedItems.length, (i) => i == index + 1);

      if (isContributing) {
        if (!item.contributors.any((e) => e.id == user.id)) {
          items[index] = item.copyWith(contributors: [
            ...item.contributors,
            user,
          ]);
        }
      } else {
        items[index] = item.copyWith(contributors: [
          ...item.contributors.where((e) => e.id != user.id),
        ]);
      }
    });

    ref
        .read(itemsContributionsProvider.notifier)
        .setItemContribution(items[index]);
  }
}

class ItemContributionDecoration extends StatelessWidget {
  const ItemContributionDecoration({
    super.key,
    required this.child,
    required this.borderColor,
  });

  final Widget child;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(Sizes.p12),
        ),
        child: child,
      ),
    );
  }
}
