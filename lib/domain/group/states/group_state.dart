import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/domain/group/data/group_repository.dart';
import 'package:split_the_bill/domain/group/group.dart';

part 'group_state.g.dart';

@riverpod
class GroupState extends _$GroupState {
  GroupRepository get _groupRepository => ref.read(groupRepositoryProvider);

  Future<Group> _getGroup(String groupId) async {
    return await _groupRepository.getGroup(groupId);
  }

  bool isGroupOwner() {
    return ref.read(authStateProvider).requireValue.id ==
        state.requireValue.owner.id;
  }

  @override
  Future<Group> build(String groupId) {
    return _getGroup(groupId);
  }
}
