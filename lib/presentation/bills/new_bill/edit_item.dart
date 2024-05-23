import 'package:flutter/material.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/item.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/presentation/bills/new_bill/group_member_list.dart';
import 'package:split_the_bill/presentation/bills/new_bill/price_text_field.dart';
import 'package:split_the_bill/presentation/shared/components/input_text_field.dart';

class EditItem extends StatefulWidget {
  const EditItem({
    super.key,
    required this.item,
    required this.group,
    required this.onChanged,
  });

  final Item item;
  final Group group;
  final Function(String, String, List<User>) onChanged;

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late List<User> contributors;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.item.name);
    priceController =
        TextEditingController(text: _parsePrice(widget.item.price));
    contributors = List.from(widget.item.contributors);
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  String _parsePrice(double price) {
    String priceString = price.toString();
    int indexOfDecimalPoint = priceString.indexOf('.');
    if (priceString
            .substring(indexOfDecimalPoint + 1, priceString.length)
            .length <
        2) {
      return "${priceString}0";
    }
    return priceString;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gapH8,
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: Sizes.p8),
                child: InputTextField(
                  controller: nameController,
                  onChanged: (name) => widget.onChanged(
                      name, priceController.text, contributors),
                  labelText: 'Item*',
                  prefixIcon: const Icon(Icons.description),
                  fillColor: backgroundGrey,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: Sizes.p8),
                child: PriceTextField(
                  controller: priceController,
                  onChanged: (price) => widget.onChanged(
                      nameController.text, price, contributors),
                  labelText: "Price*",
                  prefixIcon: const Icon(Icons.attach_money),
                  fillColor: backgroundGrey,
                ),
              ),
            ),
          ],
        ),
        gapH16,
        const Text("Contributors"),
        gapH8,
        GroupMemberList(
          members: widget.group.members,
          contributors: contributors,
          onChanged: (newContributors) {
            contributors = newContributors;
            widget.onChanged(
              nameController.text,
              priceController.text,
              contributors,
            );
          },
        ),
      ],
    );
  }
}
