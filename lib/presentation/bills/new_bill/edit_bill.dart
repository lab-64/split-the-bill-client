import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/item.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';
import 'package:split_the_bill/presentation/bills/new_bill/controllers.dart';
import 'package:split_the_bill/presentation/bills/new_bill/edit_item.dart';
import 'package:split_the_bill/presentation/shared/components/headline.dart';
import 'package:split_the_bill/presentation/shared/components/primary_button.dart';

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

  @override
  void initState() {
    super.initState();
    items = ref.read(itemsProvider(widget.bill.id));
    itemExpanded = List.generate(items.length, (index) => true);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(editBillControllerProvider,
        (_, next) => next.showSnackBarOnError(context));
    items = ref.watch(itemsProvider(widget.bill.id));

    return Padding(
      padding: const EdgeInsets.all(Sizes.p24),
      child: Column(
        children: [
          Expanded(
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
                          Headline(
                              title: items[index].name.isNotEmpty
                                  ? items[index].name
                                  : 'Item ${index + 1}'),
                          Row(
                            children: [
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
                        ],
                      ),
                    ),
                    const Divider(),
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
                              color: Colors.green.shade400,
                            ),
                          ),
                        ],
                      ),
                  ],
                );
              },
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
