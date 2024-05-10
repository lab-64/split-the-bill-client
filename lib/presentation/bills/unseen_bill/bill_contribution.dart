import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
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
    final user = ref.watch(authStateProvider).requireValue;

    // Check if any contributor of the item matches the current user
    return items.any(
      (e) => e.id == item.id && e.contributors.any((e) => e.id == user.id),
    );
  }

  // Update contribution status for the current user on the specified item
  void _updateContributionStatus(bool isContributing, int index) async {
    // Get the current user and the item to update
    final user = ref.watch(authStateProvider).requireValue;
    final item = items[index];

    setState(() {
      expandedItems =
          List.generate(expandedItems.length, (i) => i == index + 1);

      // Update item's contributors based on the contribution status
      if (isContributing) {
        if (!item.contributors.any((e) => e.id == user.id)) {
          // Add user to contributors if not already present
          items[index] = item.copyWith(contributors: [
            ...item.contributors,
            user,
          ]);
        }
      } else {
        // Remove user from contributors
        items[index] = item.copyWith(
          contributors: [
            ...item.contributors.where((e) => e.id != user.id),
          ],
        );
      }
    });

    // Notify the provider about the updated item contribution
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
