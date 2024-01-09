import 'package:flutter/material.dart';

import '../../../constants/app_sizes.dart';
import '../../../domain/group/group.dart';
import '../../../domain/item/item.dart';
import 'item_container.dart';
import 'bill_header.dart';
import '../primary_button.dart';
import 'item_list_controller.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen(
      {super.key,
      required this.isNewBill,
      required this.existingItems,
      this.group,
      this.billId});

  final bool isNewBill;
  final List<Item> existingItems;
  final Group? group;
  final String? billId;

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {

  final ScrollController scrollController = ScrollController();
  ItemListController itemController = ItemListController();
  List<ItemContainer> itemContainers = [];

  //concerning existing bill
  Group? group;
  bool newBill = true;

  @override
  void initState() {
    super.initState();

    if (widget.existingItems.isNotEmpty) {
      for (Item item in widget.existingItems) {
        itemController.addExistingItem(item);
      }

      if (widget.group != null) {
        group = widget.group;
      }

      newBill = false;
    } else {
      itemController.addNewItem();
    }
  }

  @override
  void dispose() {
    itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    itemContainers = itemController.getItems();
    itemController.setUpdateListView(updateListView);

    return Padding(
      padding: const EdgeInsets.all(Sizes.p32),
      child: Column(
        children: [
          BillHeader(
            names: itemController.getNames(),
            prices: itemController.getPrices(),
            group: group,
            changeGroup: setGroup,
            newBill: newBill,
            billId: widget.billId
          ),
          Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: PrimaryButton(
              isLoading: false,
              text: 'Add Item',
              onPressed: () {
                setState(() {
                  itemController.addNewItem();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Sizes.p8),
            child: ListView(
              //TODO scrolling function doesn't work
              controller: scrollController,
              shrinkWrap: true,
              children: [for (final item in itemContainers) item],
            ),
          ),
        ],
      ),
    );
  }

  void setGroup(Group group) {
    setState(() {
      this.group = group;
    });
  }

  void updateListView() {
    setState(() {
      itemContainers = itemController.getItems();
    });
  }
}
