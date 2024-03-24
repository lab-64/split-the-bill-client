import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/domain/user/data/user_api.dart';
import 'package:split_the_bill/domain/user/data/user_repository.dart';
import 'package:split_the_bill/infrastructure/http_client.dart';

class RemoteUserRepository extends UserRepository {
  RemoteUserRepository({required this.api, required this.client});

  final UserAPI api;
  final HttpClient client;

  @override
  Future<User> update(User user) => client.put(
        uri: api.updateUser(user.id),
        body: user.toMap(),
        builder: (data) => User.fromMap(data),
      );
}
