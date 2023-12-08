import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/presentation/new_bill/new_bill_bar.dart';
import 'package:split_the_bill/presentation/shared/primary_button.dart';

import 'item_container.dart';

class NewBillScreen extends StatefulWidget {
  const NewBillScreen({super.key});

  @override
  State<NewBillScreen> createState() => _NewBillScreenState();
}

class _NewBillScreenState extends State<NewBillScreen> {
  final ScrollController scrollController = ScrollController();
  List<TextEditingController> names = [];
  List<TextEditingController> prices = [];
  List<ItemContainer> items = [];
  Group? group;

  @override
  void dispose() {
    names.map((e) => e.dispose());
    prices.map((e) => e.dispose());
    super.dispose();
  }

  @override
  void initState() {
    addItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Bill"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p32),
        child: Column(
          children: [
            NewBillBar(
              names: names,
              prices: prices,
              group: group,
              changeGroup: setGroup,
            ),
            Padding(
              padding: const EdgeInsets.all(Sizes.p16),
              child: PrimaryButton(
                isLoading: false,
                text: 'Add Item',
                onPressed: () => {addItem()},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Sizes.p8),
              child: ListView(
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

  void addItem() {
    setState(() {
      names.add(TextEditingController());
      prices.add(TextEditingController());
      items.add(ItemContainer(
        name: names.last,
        price: prices.last,
        index: items.length,
        deleteSelf: deleteItem,
        onChanged: onChange,
      ));
    });
  }

  void deleteItem(int index) {
    if (items.length > 1) {
      setState(() {
        items.removeAt(index);
        names.removeAt(index);
        prices.removeAt(index);
      });
    }
  }

  void onChange(String value, bool name, int index) {
    setState(() {
      if (name) {
        names[index].text = value;
      } else {
        prices[index].text = value;
      }
    });
  }
}
