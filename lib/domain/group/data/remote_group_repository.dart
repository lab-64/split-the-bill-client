import 'package:split_the_bill/domain/group/data/group_api.dart';
import 'package:split_the_bill/domain/group/data/group_repository.dart';
import 'package:split_the_bill/domain/group/group_transaction.dart';
import 'package:split_the_bill/infrastructure/http_client.dart';

import '../../../infrastructure/shared_preferences.dart';
import '../group.dart';

class RemoteGroupRepository extends GroupRepository {
  RemoteGroupRepository(
      {required this.api, required this.client, required this.sharedUtility});

  final GroupAPI api;
  final HttpClient client;
  final SharedUtility sharedUtility;

  @override
  Future<Group> getGroup(String groupId) => client.get(
        uri: api.getGroup(groupId),
        builder: (data) => Group.fromMap(data),
      );

  @override
  Future<List<Group>> getGroupsByUser(String userId) async {
    try {
      // get groups from server
      final groups = await client.get(
        uri: api.getGroupsByUser(userId),
        builder: (data) {
          if (data == null || data.isEmpty) return [];
          return data.map((g) => Group.fromMap(g)).toList();
        },
      );
      sharedUtility.setGroups(groups);
      return groups;
    } catch (e) {
      // load groups from shared preferences if server is down
      return sharedUtility.getGroups();
    }
  }

  @override
  Future<Group> create(Group group) => client.post(
        uri: api.createGroup(),
        body: group.toMap(),
        builder: (data) => Group.fromMap(data),
      );

  @override
  Future<Group> edit(Group group) {
    return client.put(
      uri: api.editGroup(group.id),
      body: group.toMap(),
      builder: (data) => Group.fromMap(data),
    );
  }

  @override
  Future<void> delete(String groupId) => client.delete(
        uri: api.deleteGroup(groupId),
      );

  @override
  Future<void> acceptInvitation(String invitationId) {
    return client.post(
      uri: api.acceptInvitation(invitationId),
      body: {},
      builder: (_) {},
    );
  }

  @override
  Future<void> reset(String groupId) => client.post(
        uri: api.resetGroup(groupId),
        body: {},
        builder: (data) => data,
      );

  @override
  Future<List<GroupTransaction>> getAllTransactions(String userId) =>
      client.get(
        uri: api.getAllTransactions(userId),
        builder: (data) => data?.isNotEmpty == true
            ? data
                .map((groupData) => GroupTransaction.fromMap(groupData))
                .toList()
                .cast<GroupTransaction>()
            : [],
      );
}
