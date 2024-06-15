import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/item.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/presentation/bills/new_bill/controllers.dart';
import 'package:split_the_bill/presentation/bills/new_bill/edit_item_modal.dart';
import 'package:split_the_bill/presentation/bills/new_bill/scan_bill_modal.dart';
import 'package:split_the_bill/presentation/shared/components/bottom_modal.dart';
import 'package:split_the_bill/presentation/shared/components/placeholder_display.dart';
import 'package:split_the_bill/presentation/shared/components/primary_button.dart';
import 'package:split_the_bill/presentation/shared/extensions/currency_formatter.dart';

class ItemsTab extends ConsumerStatefulWidget {
  const ItemsTab({
    super.key,
    required this.getImage,
    required this.group,
    required this.bill,
    required this.userId,
    required this.allSet,
    required this.setAll,
  });

  final Function(ImageSource) getImage;
  final Group group;
  final Bill bill;
  final String userId;
  final bool allSet;
  final Function setAll;

  @override
  ConsumerState<ItemsTab> createState() => _ItemsTabState();
}

class _ItemsTabState extends ConsumerState<ItemsTab> {
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

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p24),
            child: Column(
              children: [
                if (widget.bill.items.isEmpty)
                  const PlaceholderDisplay(
                    icon: Icons.list,
                    message: "No items added yet",
                  ),
                if (widget.bill.items.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 8),
                        child: Text(
                          "Items: ${widget.bill.items.length}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16, bottom: 8),
                        child: Text(
                            "Total Price: ${widget.bill.items.fold(0.0, (prev, item) => prev + item.price).toCurrencyString()}",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => widget.setAll(!widget.allSet),
                        icon: Icon(widget.allSet
                            ? Icons.check_box
                            : Icons.check_box_outline_blank),
                      ),
                      Text(widget.allSet
                          ? 'Set no Contributors'
                          : 'Set all Contributors')
                    ],
                  )
                ],
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.bill.items.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      onDismissed: (_) => {
                        ref
                            .read(editBillControllerProvider.notifier)
                            .removeItem(
                              index,
                            ),
                      },
                      background: const Card(
                        color: Colors.red,
                        elevation: 0,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      key: Key(
                        widget.bill.items[index].name,
                      ),
                      child: GestureDetector(
                        onTap: () => showBottomModal(
                          context,
                          "Edit Item",
                          EditItemModal(
                            index: index,
                            item: widget.bill.items[index],
                            group: widget.group,
                          ),
                        ),
                        child: Card(
                          color: Colors.white,
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: Sizes.p8,
                              horizontal: Sizes.p16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.bill.items[index].name,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.person,
                                          size: 16,
                                        ),
                                        gapW4,
                                        Text(
                                          widget.bill.items[index].contributors
                                              .length
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      widget.bill.items[index].price
                                          .toCurrencyString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      _calculateBalance(
                                        widget.bill.items[index],
                                        widget.bill.owner.id,
                                      ).toCurrencyString(),
                                      style: TextStyle(
                                        color: _calculateBalance(
                                                  widget.bill.items[index],
                                                  widget.bill.owner.id,
                                                ) >
                                                0
                                            ? Colors.green
                                            : _calculateBalance(
                                                      widget.bill.items[index],
                                                      widget.bill.owner.id,
                                                    ) <
                                                    0
                                                ? Colors.red
                                                : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                gapH16,
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        onPressed: () => showBottomModal(
                          context,
                          "Add Item",
                          EditItemModal(
                            index: -1,
                            item: Item.getDefault(),
                            group: widget.group,
                          ),
                        ),
                        icon: Icons.add,
                        text: "Add Item",
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                ),
                gapH8,
                if (widget.bill.items.isEmpty) ...[
                  const Text(
                    "Or",
                    style: TextStyle(fontSize: 18),
                  ),
                  gapH8,
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          onPressed: () => showBottomModal(
                            context,
                            "Scan Bill",
                            ScanBillModal(
                              getImage: widget.getImage,
                            ),
                          ),
                          icon: Icons.camera_alt,
                          text: "Scan Items",
                          backgroundColor: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
