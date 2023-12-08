import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/domain/item/item.dart';
import 'package:split_the_bill/presentation/new_bill/controllers.dart';
import 'package:split_the_bill/presentation/new_bill/new_bill_groups_dropdown.dart';
import 'package:split_the_bill/presentation/shared/primary_button.dart';

class NewBillBar extends StatefulWidget {
  const NewBillBar(
      {super.key,
      required this.names,
      required this.prices,
      required this.group,
      required this.changeGroup});

  final List<TextEditingController> names;
  final List<TextEditingController> prices;
  final Group? group;
  final Function changeGroup;

  @override
  State<NewBillBar> createState() => _NewBillBarState();
}

class _NewBillBarState extends State<NewBillBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 2,
          child: Consumer(
            builder: (context, ref, child) {
              return NewBillGroupsDropdown(
                initialSelection: widget.group,
                onSelected: (Group? value) {
                  setState(() => widget.changeGroup(value));
                },
              );
            },
          ),
        ),
        gapW16,
        Flexible(
          flex: 1,
          child: Consumer(
            builder: (context, ref, child) {
              return Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      isLoading: ref.watch(newBillControllerProvider).isLoading,
                      onPressed: () {
                        //TODO make more simple
                        if (widget.group == null) {
                          return;
                        }
                        List<Item> itemList = [];
                        for (var i = 0; i < widget.names.length; i++) {
                          itemList.add(Item(
                              id: i.toString(),
                              name: widget.names[i].text,
                              price: widget.prices[i].text == ""
                                  ? 0
                                  : double.parse(widget.prices[i].text),
                              billId: '',
                              contributors: []));
                        }
                        ref
                            .read(newBillControllerProvider.notifier)
                            .addBill(widget.names[0].text, widget.group!.id,
                                itemList)
                            .then((_) => context.pop());
                      },
                      text: 'Save',
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
