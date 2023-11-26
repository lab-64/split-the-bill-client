import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/data/auth_api.dart';
import 'package:split_the_bill/auth/data/remote_auth_repository.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/infrastructure/http_client.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);

  Future<void> register(String email, String password);
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  // TODO: Replace with a real repository when it's available
  return RemoteAuthRepository(
    api: AuthAPI(),
    client: ref.read(httpClientProvider),
  );
}
