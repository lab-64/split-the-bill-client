import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';
import 'package:split_the_bill/presentation/new_bill/controllers.dart';
import 'package:split_the_bill/presentation/shared/primary_button.dart';

class NewBillScreen extends ConsumerStatefulWidget {
  const NewBillScreen({super.key});

  @override
  ConsumerState<NewBillScreen> createState() => _NewBillScreenState();
}

class _NewBillScreenState extends ConsumerState<NewBillScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  Group? group;

  @override
  void dispose() {
    name.dispose();
    price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groups = ref.watch(groupsStateProvider).requireValue;

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Bill"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p32),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: Colors.black),
              controller: name,
              decoration: const InputDecoration(
                labelText: "Name",
                prefixIcon: Icon(Icons.drive_file_rename_outline),
              ),
            ),
            TextField(
              style: const TextStyle(color: Colors.black),
              controller: price,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.attach_money,
                ),
                labelText: "Price",
              ),
            ),
            gapH32,
            Row(
              children: [
                Expanded(
                  child: DropdownMenu<Group>(
                    label: const Text("Group"),
                    textStyle: const TextStyle(color: Colors.black),
                    initialSelection: group,
                    onSelected: (Group? value) {
                      setState(() {
                        group = value;
                      });
                    },
                    dropdownMenuEntries:
                        groups.map<DropdownMenuEntry<Group>>((Group group) {
                      return DropdownMenuEntry<Group>(
                          value: group, label: group.name);
                    }).toList(),
                  ),
                ),
              ],
            ),
            gapH48,
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    isLoading: ref.watch(newBillControllerProvider).isLoading,
                    onPressed: () => ref
                        .read(newBillControllerProvider.notifier)
                        .addBill(name.text, price.text, group!.id)
                        .then((_) => context.pop()),
                    text: 'Add',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
