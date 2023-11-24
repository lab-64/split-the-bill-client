import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/domain/group/data/group_api.dart';
import 'package:split_the_bill/domain/group/data/remote_group_repository.dart';
import 'package:split_the_bill/infrastructure/http_client.dart';

import '../group.dart';

part 'group_repository.g.dart';

abstract class GroupRepository {
  Future<Group> getGroup(String groupId);

  Future<List<Group>> getGroupsByUser(String userId);

  Future<bool> add(Group group);
}

@Riverpod(keepAlive: true)
GroupRepository groupRepository(GroupRepositoryRef ref) {
  // TODO: Replace with a real repository when it's available
  return RemoteGroupRepository(
    api: GroupAPI(),
    client: ref.read(httpClientProvider),
  );
}
