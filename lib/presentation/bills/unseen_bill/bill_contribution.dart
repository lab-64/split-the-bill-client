import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/presentation/bills/unseen_bill/item_contribution.dart';
import 'package:split_the_bill/presentation/bills/unseen_bill/item_contribution_decoration.dart';
import 'package:split_the_bill/presentation/shared/components/ellipse_text.dart';

import '../../../constants/app_sizes.dart';
import '../../../domain/bill/bill.dart';
import '../../../domain/bill/item.dart';

class BillContribution extends ConsumerStatefulWidget {
  const BillContribution({
    super.key,
    required this.bill,
    required this.changeContributionMapping,
  });

  final Bill bill;
  final Function changeContributionMapping;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BillContributionState();
}

class _BillContributionState extends ConsumerState<BillContribution> {
  late List<Item> unseenItems;
  List<Item> seenItems = [];
  Map<Item, bool> contributionMapping = {};
  late List<bool> itemExpanded;

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    unseenItems = List.from(widget.bill.items);
    itemExpanded = List.generate(seenItems.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(Sizes.p12),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    controller: _controller,
                    itemCount: seenItems.length + 1,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index < seenItems.length)
                            ItemContributionDecoration(
                              borderColor: itemExpanded[index]
                                  ? Colors.grey
                                  : Colors.white,
                              child: Column(
                                children: [
                                  ListTile(
                                    onTap: () => {
                                      setState(() {
                                        itemExpanded[index] =
                                            !itemExpanded[index];
                                      })
                                    },
                                    leading: const Icon(
                                      Icons.inventory,
                                      color: Colors.blue,
                                    ),
                                    title: EllipseText(
                                      text: seenItems[index].name,
                                      size: Sizes.p64,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    trailing: contributionMapping
                                            .containsKey(seenItems[index])
                                        ? contributionMapping[seenItems[index]]!
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.green,
                                              )
                                            : const Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              )
                                        : const Text("An error has occurred"),
                                  ),
                                  if (itemExpanded[index]) ...[
                                    const Divider(),
                                    ItemContribution(
                                      changeContribution: _editContribution,
                                      item: seenItems[index],
                                      index: index,
                                    )
                                  ],
                                ],
                              ),
                            ),
                          if ((index == seenItems.length - 1 ||
                                  (index == 0 && seenItems.isEmpty)) &&
                              unseenItems.isNotEmpty)
                            ItemContributionDecoration(
                                borderColor: Colors.grey,
                                child: ItemContribution(
                                  changeContribution: _addContribution,
                                  item: unseenItems[0],
                                  index: 0,
                                ))
                          else if (index == seenItems.length - 1)
                            const ItemContributionDecoration(
                                borderColor: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("All items have been seen"),
                                ))
                        ],
                      );
                    })),
          ],
        ));
  }

  void _addContribution(bool value, int index) async {
    setState(() {
      Item item = unseenItems.removeAt(index);
      seenItems.add(item);
      contributionMapping.addAll({item: value});

      itemExpanded.clear();
      itemExpanded.addAll(List.generate(seenItems.length, (index) => false));

      widget.changeContributionMapping(contributionMapping);
    });

    await Future.delayed(
        const Duration(milliseconds: 100)); //TODO make smoother
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  void _editContribution(bool value, int index) {
    setState(() {
      Item item = seenItems[index];
      contributionMapping[item] = value;

      itemExpanded[index] = !itemExpanded[index];

      widget.changeContributionMapping(contributionMapping);
    });
  }
}
