import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';

import '../data/group_repository.dart';
import '../group_transaction.dart';

part 'groups_transaction_state.g.dart';

@riverpod
class GroupsTransactionState extends _$GroupsTransactionState {
  GroupRepository get _groupRepository => ref.read(groupRepositoryProvider);

  @override
  Future<List<GroupTransaction>> build() async {
    final user = ref.watch(authStateProvider).requireValue;
    return _sortTransactions(
        await _groupRepository.getAllTransactions(user.id));
  }

  List<GroupTransaction> _sortTransactions(
      List<GroupTransaction> transactions) {
    List<String> groups = transactions.map((e) => e.groupName).toList();
    groups = [
      ...{...groups}
    ];
    List<List<GroupTransaction>> sortedByGroup = [];

    for (var group in groups) {
      sortedByGroup.add(
          transactions.where((element) => element.groupName == group).toList());
    }

    sortedByGroup
        .map((list) => list.sort((a, b) => a.date.compareTo(b.date)))
        .toList();

    List<GroupTransaction> sortedGroupTransactions = [];
    for (var element in sortedByGroup) {
      sortedGroupTransactions.addAll(element);
    }

    return sortedGroupTransactions;
  }
}
