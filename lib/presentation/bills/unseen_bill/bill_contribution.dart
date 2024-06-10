import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/presentation/bills/unseen_bill/controllers.dart';
import 'package:split_the_bill/presentation/bills/unseen_bill/item_contribution.dart';
import 'package:split_the_bill/presentation/shared/components/fade_text.dart';

import '../../shared/components/primary_button.dart';

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
    final itemContributions =
        ref.watch(itemsContributionsProvider(widget.bill));
    final items = widget.bill.items;

    return Padding(
      padding: const EdgeInsets.all(Sizes.p24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PrimaryButton(
                  onPressed: () => _updateAll(true, items.length),
                  icon: Icons.check,
                  backgroundColor: Colors.green.shade300,
                  text: "Set All",
                ),
              ),
              gapW8,
              Expanded(
                child: PrimaryButton(
                  onPressed: () => _updateAll(false, items.length),
                  icon: Icons.close,
                  backgroundColor: Colors.red.shade300,
                  text: "Clear All",
                ),
              ),
            ],
          ),
          gapH8,
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
                          title: FadeText(
                            text: items[index].name,
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          trailing: itemContributions[index].contributed
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

  // Update contribution status for the current user on the specified item
  void _updateContributionStatus(bool isContributing, int index) async {
    setState(() {
      expandedItems =
          List.generate(expandedItems.length, (i) => i == index + 1);
    });

    // Notify the provider about the updated item contribution
    ref
        .read(itemsContributionsProvider(widget.bill).notifier)
        .setItemContribution(widget.bill.items[index].id, isContributing);
  }

  void _updateAll(bool isContributing, int itemLength) {
    for (var i = 0; i < itemLength; i++) {
      _updateContributionStatus(isContributing, i);
    }
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
