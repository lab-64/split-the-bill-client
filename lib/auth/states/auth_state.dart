import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/data/auth_repository.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/test_data.dart';

part 'auth_state.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  @override
  FutureOr<User> build() {
    return testUsers[0];
    //return const User(id: "", username: "", email: "");
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() => _authRepository.login(email, password));
  }
}
