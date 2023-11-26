import 'package:split_the_bill/domain/group/data/group_api.dart';
import 'package:split_the_bill/domain/group/data/group_repository.dart';
import 'package:split_the_bill/infrastructure/http_client.dart';

import '../group.dart';

class RemoteGroupRepository extends GroupRepository {
  RemoteGroupRepository({required this.api, required this.client});

  final GroupAPI api;
  final HttpClient client;

  @override
  Future<Group> getGroup(String groupId) => client.get(
        uri: api.getGroup(groupId),
        builder: (data) => Group.fromMap(data),
      );

  @override
  Future<List<Group>> getGroupsByUser(String userId) async {
    try {
      return await client.get<List<Group>>(
        uri: api.getGroupsByUser(userId),
        builder: (data) {
          if (data == null || data.isEmpty) {
            return [];
          }
          //TODO
          return data.map((groupData) => Group.fromMap(groupData)).toList()
              as List<Group>;
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> add(Group group) => client.post(
        uri: api.createGroup(),
        body: group.toMap(),
        // TODO
        builder: (data) => true,
      );
}
