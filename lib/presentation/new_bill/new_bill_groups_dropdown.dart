import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';

class NewBillGroupsDropdown extends ConsumerWidget {
  const NewBillGroupsDropdown(
      {super.key, required this.initialSelection, required this.onSelected});
  final Group? initialSelection;
  final Function(Group?) onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(groupsStateProvider).requireValue;

    return DropdownMenu<Group>(
      label: const Text("Group"),
      textStyle: const TextStyle(color: Colors.black),
      initialSelection: initialSelection,
      onSelected: onSelected,
      dropdownMenuEntries: groups.map<DropdownMenuEntry<Group>>((Group group) {
        return DropdownMenuEntry<Group>(value: group, label: group.name);
      }).toList(),
    );
  }
}
