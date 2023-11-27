import 'package:split_the_bill/domain/group/data/group_api.dart';
import 'package:split_the_bill/domain/group/data/group_repository.dart';
import 'package:split_the_bill/infrastructure/http_client.dart';

import '../group.dart';

class RemoteGroupRepository extends GroupRepository {
  RemoteGroupRepository({required this.api, required this.client});

  final GroupAPI api;
  final HttpClient client;

  @override
  Future<Group> getGroup(String groupId) async => client.get(
        uri: api.getGroup(groupId),
        builder: (data) => Group.fromMap(data),
      );

  @override
  Future<List<Group>> getGroupsByUser(String userId) async => client.get(
        uri: api.getGroupsByUser(userId),
        builder: (data) => data
            .map((groupData) => Group.fromMap(groupData))
            .toList()
            .cast<Group>(),
      );

  @override
  Future<bool> add(Group group) => client.post(
        uri: api.createGroup(),
        body: group.toMap(),
        // TODO
        builder: (data) => true,
      );
}
