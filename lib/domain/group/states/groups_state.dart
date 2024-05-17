import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/domain/group/data/group_repository.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/domain/group/states/dummy_transaction_data.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';

import '../group_transaction.dart';

part 'groups_state.g.dart';

@Riverpod(keepAlive: true)
class GroupsState extends _$GroupsState {
  GroupRepository get _groupRepository => ref.read(groupRepositoryProvider);

  @override
  Future<List<Group>> build() {
    final user = ref.watch(authStateProvider).requireValue;
    return _getGroupsByUser(user.id);
  }

  Future<List<Group>> _getGroupsByUser(String userId) async {
    return await _groupRepository.getGroupsByUser(userId);
  }

  Future<void> create(Group group) async {
    final newGroup = await _groupRepository.create(group);
    final previousState = await future;
    state = AsyncData([...previousState, newGroup]);
  }

  Future<void> edit(Group group) async {
    final updatedGroup = await _groupRepository.edit(group);
    ref.invalidateSelf();
    ref.invalidate(groupStateProvider(updatedGroup.id));
  }

  Future<void> delete(String groupId) async {
    await _groupRepository.delete(groupId);
    ref.invalidateSelf();

    // Wait for the ref to be computed
    await future;
  }

  Future<List<GroupTransaction>> getAllTransactions() async {
    return Future.delayed(
        const Duration(seconds: 1), () => DummyTransactionData().data);
  }
}

@Riverpod(keepAlive: true)
class TransactionsSate extends _$TransactionsSate {

  @override
  Future<List<GroupTransaction>> build() {
    return Future.delayed(const Duration(seconds: 1), () {
      return DummyTransactionData().data;
    });
  }
}
