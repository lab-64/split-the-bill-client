import 'package:split_the_bill/domain/group/data/group_repository.dart';
import 'package:split_the_bill/infrastructure/group_api.dart';
import 'package:split_the_bill/infrastructure/http_client.dart';

import '../group.dart';

class RemoteGroupRepository extends GroupRepository {
  RemoteGroupRepository({required this.api, required this.client});

  final GroupAPI api;
  final HttpClient client;

  @override
  Future<Group> getGroup(String groupId) {
    // TODO: implement getGroup
    throw UnimplementedError();
  }

  @override
  Future<List<Group>> getGroupsByUser(String userId) {
    // TODO: implement getGroupsByUser
    throw UnimplementedError();
  }

  @override
  Future<bool> add(Group group) {
    // TODO: implement add
    throw UnimplementedError();
  }
}
