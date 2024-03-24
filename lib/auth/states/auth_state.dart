import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/data/auth_repository.dart';
import 'package:split_the_bill/auth/user.dart';

part 'auth_state.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  @override
  FutureOr<User> build() {
    return const User(id: "", email: "");
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() => _authRepository.login(email, password));
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    //register
    state =
        await AsyncValue.guard(() => _authRepository.register(email, password));
    //login if register successful
    if (!state.hasError) {
      state =
          await AsyncValue.guard(() => _authRepository.login(email, password));
    }
  }
}
