import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/item.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';
import 'package:split_the_bill/presentation/bills/new_bill/controllers.dart';
import 'package:split_the_bill/presentation/bills/new_bill/edit_item.dart';
import 'package:split_the_bill/presentation/shared/components/ellipse_headline.dart';
import 'package:split_the_bill/presentation/shared/components/headline.dart';
import 'package:split_the_bill/presentation/shared/components/primary_button.dart';

import 'edit_bill_header.dart';

class EditBill extends ConsumerStatefulWidget {
  const EditBill({super.key, required this.bill, required this.group});

  final Bill bill;
  final Group group;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditBillState();
}

class _EditBillState extends ConsumerState<EditBill> {
  late List<Item> items;
  late List<bool> itemExpanded;
  late TextEditingController _nameController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    items = ref.read(itemsProvider(widget.bill.id));
    itemExpanded = List.generate(items.length, (index) => true);

    _nameController = TextEditingController(text: widget.bill.name);
    _dateController = TextEditingController(text: widget.bill.date.toString());
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(editBillControllerProvider,
        (_, next) => next.showSnackBarOnError(context));

    // Reinitialize itemExpanded when items change
    ref.listen(
      itemsProvider(widget.bill.id),
      (_, next) => itemExpanded = List.generate(next.length, (index) => false),
    );

    items = ref.watch(itemsProvider(widget.bill.id));

    return Padding(
      padding: const EdgeInsets.all(Sizes.p24),
      child: Column(
        children: [
          EditBillHeader(
            dateController: _dateController,
            nameController: _nameController,
          ),
          gapH16,
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              itemExpanded[index] = !itemExpanded[index];
                            });
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              EllipseHeadline(
                                  size: Sizes.p64 * 2.5,
                                  title: items[index].name.isNotEmpty
                                      ? items[index].name
                                      : 'Item ${index + 1}'),
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Headline(title: '€ ${items[index].price}'),
                                    gapW8,
                                    const VerticalDivider(),
                                    if (items.length > 1)
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () => _removeItem(index),
                                      ),
                                    Icon(
                                      itemExpanded[index]
                                          ? Icons.arrow_drop_up
                                          : Icons.arrow_drop_down,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Divider(),
                        ),
                        gapH8,
                        if (itemExpanded[index]) ...[
                          EditItem(
                            item: items[index],
                            group: widget.group,
                            onChanged: (name, price, contributors) =>
                                _updateItem(index, name, price, contributors),
                          ),
                          gapH12,
                        ],
                        if (index == items.length - 1)
                          Column(
                            children: [
                              gapH8,
                              SizedBox(
                                width: double.infinity,
                                child: PrimaryButton(
                                  onPressed: _addItem,
                                  text: "+1 Item",
                                ),
                              ),
                            ],
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addItem() {
    ref.read(itemsProvider(widget.bill.id).notifier).addItem(Item.getDefault());

    setState(() {
      itemExpanded.clear();
      itemExpanded.addAll(List.generate(items.length, (index) => false));
      itemExpanded.add(true);
    });
  }

  void _updateItem(
      int index, String name, String price, List<User> contributors) {
    ref
        .read(itemsProvider(widget.bill.id).notifier)
        .updateItem(index, name, price, contributors);
  }

  void _removeItem(int index) {
    ref.read(itemsProvider(widget.bill.id).notifier).removeItem(index);

    setState(() {
      itemExpanded.removeAt(index);
      itemExpanded = List.generate(itemExpanded.length, (index) => false);
    });
  }
}
