import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/item.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/presentation/bills/new_bill/group_member_list.dart';

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
    priceController = TextEditingController(text: widget.item.price.toString());
    contributors = List.from(widget.item.contributors);
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: nameController,
          onChanged: (name) =>
              widget.onChanged(name, priceController.text, contributors),
          decoration: InputDecoration(
            labelText: 'Description',
            prefixIcon: const Icon(Icons.description),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
        gapH24,
        TextField(
          controller: priceController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$')),
          ],
          onChanged: (price) =>
              widget.onChanged(nameController.text, price, contributors),
          decoration: InputDecoration(
            labelText: 'Price',
            prefixIcon: const Icon(Icons.attach_money),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
        gapH24,
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
        gapH24,
      ],
    );
  }
}
