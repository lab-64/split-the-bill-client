import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/domain/item/item.dart';
import 'package:split_the_bill/presentation/shared/bill/controllers.dart';
import 'package:split_the_bill/presentation/new_bill/new_bill_groups_dropdown.dart';
import 'package:split_the_bill/presentation/shared/primary_button.dart';

class BillBar extends StatefulWidget {
  const BillBar(
      {super.key,
      required this.names,
      required this.prices,
      required this.group,
      required this.changeGroup,
      required this.newBill,
      this.billId});

  final List<TextEditingController> names;
  final List<TextEditingController> prices;
  final Group? group;
  final Function changeGroup;
  final bool newBill;
  final String? billId;

  @override
  State<BillBar> createState() => _BillBarState();
}

class _BillBarState extends State<BillBar> {
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
                      isLoading: ref.watch(billControllerProvider).isLoading,
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
                        if (widget.newBill) {
                          //addBill
                          ref
                              .read(billControllerProvider.notifier)
                              .addBill(widget.names[0].text, widget.group!.id,
                                  itemList)
                              .then((_) => context.pop());
                        } else {
                          //editBill
                          ref
                              .read(billControllerProvider.notifier)
                              .editBill(widget.billId!, widget.names[0].text,
                                  widget.group!.id, itemList)
                              .then((_) => context.pop());
                        }
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
