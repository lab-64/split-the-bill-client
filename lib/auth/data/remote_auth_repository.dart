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
    final credentials = {
      'email': email,
      'password': password,
    };

    return client.post(
      uri: api.getLogin(),
      body: credentials,
      builder: (data) => User.fromMap(data),
      isLogin: true,
    );
  }

  @override
  Future<User> register(String email, String password) {
    final credentials = {
      'email': email,
      'password': password,
    };

    return client.post(
      uri: api.getRegister(),
      body: credentials,
      builder: (data) => User.fromMap(data),
      isLogin: true,
    );
  }
}
