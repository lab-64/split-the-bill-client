import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/domain/group/data/group_repository.dart';

import '../group.dart';

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

  Future<bool> add(Group group) async {
    final success = await _groupRepository.add(group);
    if (success) ref.invalidateSelf();
    return success;
  }
}
