import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/domain/user/data/remote_user_repository.dart';
import 'package:split_the_bill/domain/user/data/user_api.dart';
import 'package:split_the_bill/infrastructure/http_client.dart';

part 'user_repository.g.dart';

abstract class UserRepository {
  Future<User> update(User user);
}

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) {
  return RemoteUserRepository(
    api: UserAPI(),
    client: ref.read(httpClientProvider),
  );
}
