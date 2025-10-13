import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/domain/group/data/group_repository.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';
import 'package:split_the_bill/infrastructure/shared_preferences.dart';

import 'groups_transaction_state.dart';

part 'groups_state.g.dart';

@riverpod
class GroupsState extends _$GroupsState {
  GroupRepository get _groupRepository => ref.read(groupRepositoryProvider);

  @override
  Future<List<Group>> build() async {
    final user = ref.watch(authStateProvider).requireValue;
    return await _getGroupsByUser(user.id);
  }

  Future<List<Group>> _getGroupsByUser(String userId) async {
    try {
      // try to get groups from server
      List<Group> groups = await _groupRepository.getGroupsByUser(userId);
      // store groups in shared preferences
      ref.read(sharedUtilityProvider).setGroups(groups);
      return groups;
    } catch (e) {
      // load groups from shared preferences if server is down
      final List<Group> groups = ref.read(sharedUtilityProvider).getGroups();
      return groups;
    }
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

  Future<void> acceptInvitation(String invitationId) async {
    await _groupRepository.acceptInvitation(invitationId);
    ref.invalidateSelf();

    // Wait for the ref to be computed
    await future;
  }

  Future<void> reset(String groupId) async {
    await _groupRepository.reset(groupId);
    ref.invalidateSelf();
    ref.invalidate(groupsTransactionStateProvider);

    // Wait for the ref to be computed
    await future;
  }
}
