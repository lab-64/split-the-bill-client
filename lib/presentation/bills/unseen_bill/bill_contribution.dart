import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/item.dart';
import 'package:split_the_bill/presentation/bills/unseen_bill/controllers.dart';
import 'package:split_the_bill/presentation/bills/unseen_bill/item_contribution.dart';
import 'package:split_the_bill/presentation/shared/components/ellipse_text.dart';

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
  late List<bool> expandedItems;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    expandedItems =
        List.generate(widget.bill.items.length, (index) => index == 0);
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(itemsContributionsProvider(widget.bill));

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
                          trailing: _isUserContributingToItem(items[index])
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
                            updateContribution: _updateContributionStatus,
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

  // Check if the current user is contributing to the given item
  bool _isUserContributingToItem(Item item) {
    return ref
        .read(itemsContributionsProvider(widget.bill).notifier)
        .isUserContributingToItem(item);
  }

  // Update contribution status for the current user on the specified item
  void _updateContributionStatus(bool isContributing, int index) async {
    setState(() {
      expandedItems =
          List.generate(expandedItems.length, (i) => i == index + 1);
    });

    // Notify the provider about the updated item contribution
    ref
        .read(itemsContributionsProvider(widget.bill).notifier)
        .setItemContribution(index, isContributing);
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
