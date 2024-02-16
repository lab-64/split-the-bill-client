import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/domain/group/group.dart';

class GroupsDropdown extends ConsumerWidget {
  const GroupsDropdown(
      {super.key,
      required this.selectedGroupId,
      required this.groups,
      required this.onSelected});

  final String selectedGroupId;
  final List<Group> groups;
  final Function(Group?) onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Group initialSelection = groups.firstWhere(
      (group) => group.id == selectedGroupId,
      orElse: () => groups.first,
    );

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
