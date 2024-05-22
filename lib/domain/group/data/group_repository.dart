import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/domain/group/data/group_api.dart';
import 'package:split_the_bill/domain/group/data/remote_group_repository.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/domain/group/group_transaction.dart';
import 'package:split_the_bill/infrastructure/http_client.dart';

part 'group_repository.g.dart';

abstract class GroupRepository {
  Future<Group> getGroup(String groupId);

  Future<List<Group>> getGroupsByUser(String userId);

  Future<Group> create(Group group);

  Future<Group> edit(Group group);

  Future<void> delete(String groupId);

  Future<void> acceptInvitation(String invitationId);

  Future<void> reset(String groupId);

  Future<List<GroupTransaction>> getAllTransactions(String userId);
}

@Riverpod(keepAlive: true)
GroupRepository groupRepository(GroupRepositoryRef ref) {
  return RemoteGroupRepository(
    api: GroupAPI(),
    client: ref.read(httpClientProvider),
  );
}
