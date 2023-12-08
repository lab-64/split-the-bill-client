import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/presentation/new_bill/new_bill_bar.dart';
import 'package:split_the_bill/presentation/shared/bill/item_controller.dart';
import 'package:split_the_bill/presentation/shared/primary_button.dart';

import 'item_container.dart';

class NewBillScreen extends StatefulWidget {
  const NewBillScreen({super.key});

  @override
  State<NewBillScreen> createState() => _NewBillScreenState();
}

class _NewBillScreenState extends State<NewBillScreen> {
  final ScrollController scrollController = ScrollController();
  ItemController itemController = ItemController();
  List<ItemContainer> items = [];
  Group? group;

  @override
  void dispose() {
    itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    items = itemController.getItems();
    itemController.setUpdateListView(updateListView);

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Bill"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p32),
        child: Column(
          children: [
            NewBillBar(
              names: itemController.getNames(),
              prices: itemController.getPrices(),
              group: group,
              changeGroup: setGroup,
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
                children: [for (final item in items) item],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setGroup(Group group) {
    setState(() {
      this.group = group;
    });
  }

  void updateListView() {
    //TODO maybe find a better way to update the listView, as this saves an unnecessary copy of items
    setState(() {
      items = itemController.getItems();
    });
  }
}
