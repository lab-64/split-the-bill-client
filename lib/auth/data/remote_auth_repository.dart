import 'package:split_the_bill/auth/data/auth_api.dart';
import 'package:split_the_bill/auth/data/auth_repository.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/infrastructure/http_client.dart';

class RemoteAuthRepository extends AuthRepository {
  RemoteAuthRepository({required this.api, required this.client});

  final AuthAPI api;
  final HttpClient client;

  @override
  Future<User> login(String email, String password) async {
    final Map<String, dynamic> credentials = {
      'email': email,
      'password': password,
    };

    try {
      return await client.post(
        uri: api.getLogin(),
        body: credentials,
        builder: (data) => User.fromMap(data),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
