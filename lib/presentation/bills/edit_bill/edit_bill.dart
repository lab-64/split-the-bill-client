import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/item.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';
import 'package:split_the_bill/presentation/bills/edit_bill/controllers.dart';
import 'package:split_the_bill/presentation/bills/edit_bill/edit_item.dart';
import 'package:split_the_bill/presentation/bills/edit_bill/groups_dropdown.dart';
import 'package:split_the_bill/presentation/shared/components/primary_button.dart';

class EditBill extends ConsumerStatefulWidget {
  const EditBill({super.key, required this.bill});
  final Bill bill;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditBillState();
}

class _EditBillState extends ConsumerState<EditBill> {
  late List<Group> groups;
  late List<Item> items;
  late String selectedGroupId;

  bool get isNewBill => widget.bill.id == '0';

  @override
  void initState() {
    super.initState();
    items = List.from(widget.bill.items);
    groups = ref.read(groupsStateProvider).requireValue;
    selectedGroupId = isNewBill ? groups.first.id : widget.bill.groupId;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(editBillControllerProvider,
        (_, next) => next.showSnackBarOnError(context));

    return Scaffold(
      appBar: AppBar(
        title: Text(isNewBill ? "New Bill" : "Edit Bill"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p24),
        child: Column(
          children: [
            GroupsDropdown(
              groups: groups,
              selectedGroupId: widget.bill.groupId,
              onSelected: (Group? value) {
                setState(() => selectedGroupId = value!.id);
              },
            ),
            gapH32,
            PrimaryButton(
              isLoading: false,
              icon: Icons.add_circle_outline,
              onPressed: () => _addItem(),
            ),
            gapH32,
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return EditItem(
                    item: items[index],
                    onChanged: (name, price) => _updateItem(index, name, price),
                    onDelete: () => _removeItem(index),
                  );
                },
              ),
            ),
            PrimaryButton(
              isLoading: ref.watch(editBillControllerProvider).isLoading,
              onPressed: () {
                if (isNewBill) {
                  _addBill(ref);
                } else {
                  _editBill(widget.bill, ref);
                }
              },
              icon: Icons.add,
            ),
          ],
        ),
      ),
    );
  }

  void _addItem() {
    setState(() {
      items.add(Item.getDefault());
    });
  }

  void _updateItem(int index, String name, String price) {
    setState(() {
      // TODO: Maybe it's not so great to create a new Item object every time the controller triggers "onChanged". Some other ideas?
      items[index] = items[index].copyWith(
        name: name,
        price: double.parse(price),
      );
    });
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void _addBill(WidgetRef ref) {
    ref
        .read(editBillControllerProvider.notifier)
        .addBill(selectedGroupId, items)
        .then((_) => context.pop());
  }

  void _editBill(Bill bill, WidgetRef ref) {
    ref
        .read(editBillControllerProvider.notifier)
        .editBill(bill, items)
        .then((_) => context.pop());
  }
}
