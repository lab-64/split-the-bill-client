import 'package:split_the_bill/constants/test_data.dart';
import 'package:split_the_bill/domain/group/data/group_repository.dart';

import '../group.dart';

// This repository serves as a placeholder to imitate a real repository until the actual one is established.
// When that is the case, this repository should be moved to test folder & used only for tests.
class FakeGroupRepository extends GroupRepository {
  @override
  Future<Group> getGroup(String groupId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final group = testGroups.where((group) => group.id == groupId).first;
    return group;
  }

  @override
  Future<List<Group>> getGroupsByUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return testGroups.where((group) => group.members.contains(userId)).toList();
  }

  @override
  Future<Group> create(Group group) async {
    await Future.delayed(const Duration(milliseconds: 200));
    var lastId = int.parse(testGroups.last.id);
    group = group.copyWith(id: (lastId + 1).toString());

    testGroups.add(group);
    return group;
  }
}
