import 'package:image_picker/image_picker.dart';
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
  Future<User> register(String email, String password) async {
    final credentials = {
      'email': email,
      'password': password,
    };

    return client.post(
      uri: api.getRegister(),
      body: credentials,
      builder: (data) => User.fromMap(data),
    );
  }

  @override
  Future<User> update(User user, XFile? image) => client.putMultipart(
        uri: api.updateUser(user.id),
        body: user.toMap().cast<String, String>(),
        file: image,
        builder: (data) => User.fromMap(data),
      );

  @override
  Future<void> logout() =>
      client.post(uri: api.getLogout(), builder: (data) {}, body: {});
}
