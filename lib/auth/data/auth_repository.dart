import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/data/auth_api.dart';
import 'package:split_the_bill/auth/data/remote_auth_repository.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/infrastructure/http_client.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);

  Future<User> register(String email, String password);

  Future<User> update(User user);

  Future<void> logout();
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return RemoteAuthRepository(
    api: AuthAPI(),
    client: ref.read(httpClientProvider),
  );
}
