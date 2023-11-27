import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../group.dart';
import 'fake_group_repository.dart';

part 'group_repository.g.dart';

abstract class GroupRepository {
  Future<Group> getGroup(String groupId);

  Future<List<Group>> getGroupsByUser(String userId);

  Future<bool> add(Group group);
}

@Riverpod(keepAlive: true)
GroupRepository groupRepository(GroupRepositoryRef ref) {
  // TODO: Replace with a real repository when it's available
  return FakeGroupRepository();
}
