import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/item.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/presentation/bills/new_bill/controllers.dart';
import 'package:split_the_bill/presentation/bills/new_bill/group_member_list.dart';
import 'package:split_the_bill/presentation/bills/new_bill/price_text_field.dart';
import 'package:split_the_bill/presentation/shared/components/input_text_field.dart';
import 'package:split_the_bill/presentation/shared/components/primary_button.dart';
import 'package:split_the_bill/presentation/shared/components/snackbar.dart';

import '../../shared/components/bottom_modal.dart';

class EditItemModal extends ConsumerStatefulWidget {
  const EditItemModal({
    super.key,
    required this.index,
    required this.item,
    required this.group,
  });

  final int index;
  final Item item;
  final Group group;

  @override
  ConsumerState<EditItemModal> createState() => _EditItemModalState();
}

class _EditItemModalState extends ConsumerState<EditItemModal> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<User> contributors = [];

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
        gapH16,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
          child: Row(
            children: [
              Expanded(
                child: InputTextField(
                  autofocus: true,
                  controller: nameController,
                  labelText: 'Item*',
                  prefixIcon: const Icon(Icons.description),
                  textInputAction: TextInputAction.next,
                ),
              ),
              gapW16,
              Expanded(
                child: PriceTextField(
                  controller: priceController,
                  labelText: "Price",
                  prefixIcon: const Icon(Icons.attach_money),
                ),
              ),
            ],
          ),
        ),
        gapH16,
        const Padding(
          padding: EdgeInsets.only(left: Sizes.p16),
          child: Text(
            "Contributors",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        gapH8,
        GroupMemberList(
          members: widget.group.members,
          contributors: contributors,
          onChanged: (newContributors) {
            contributors = newContributors;
          },
        ),
        Padding(
          padding: const EdgeInsets.all(Sizes.p24),
          child: Center(
            child: Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    onPressed: () => _saveItem(false),
                    text: "Ok",
                    icon: Icons.check,
                    backgroundColor: Colors.green,
                  ),
                ),
                gapW8,
                Expanded(
                    child: PrimaryButton(
                  onPressed: () {
                    _saveItem(true);
                  },
                  text: "Next Item",
                  icon: Icons.arrow_forward,
                  backgroundColor: Colors.purple,
                ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  int _getNewIndex() {
    final length = ref.read(editBillControllerProvider).items.length;
    if (widget.index == -1) {
      return -1;
    }
    if (widget.index >= (length - 1)) {
      return -1;
    }
    return widget.index + 1;
  }

  Item _getNewItem() {
    final items = ref.read(editBillControllerProvider).items;
    if (widget.index == -1) {
      return Item.getDefault();
    }
    if (widget.index >= (items.length - 1)) {
      return Item.getDefault();
    }
    return items[widget.index + 1];
  }

  void _saveItem(bool isNext) {
    if (nameController.text.isEmpty) {
      showErrorSnackBar(context, 'Please give the Item a name!');
      return;
    }
    final updatedItem = widget.item.copyWith(
      name: nameController.text,
      price: double.parse(priceController.text),
      contributors: contributors,
    );

    // If the index is -1, it means that the item is new
    if (widget.index == -1) {
      ref.read(editBillControllerProvider.notifier).addItem(updatedItem);
    } else {
      ref
          .read(editBillControllerProvider.notifier)
          .updateItem(widget.index, updatedItem);
    }

    Navigator.of(context).pop();

    if (isNext) {
      showBottomModal(
        context,
        "Add Item",
        EditItemModal(
          index: _getNewIndex(),
          item: _getNewItem(),
          group: widget.group,
        ),
      );
    }
  }
}
