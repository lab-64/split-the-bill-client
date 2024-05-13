import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/data/auth_repository.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/infrastructure/shared_preferences.dart';

part 'auth_state.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  @override
  FutureOr<User> build() {
    print(ref.read(sharedUtilityProvider).getAuthCookie());
    return const User(id: "", email: "", username: "", profileImgPath: "");
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
    state =
        await AsyncValue.guard(() => _authRepository.register(email, password));
    if (!state.hasError) {
      state =
          await AsyncValue.guard(() => _authRepository.login(email, password));
    }
  }

  Future<void> updateUser(User user, XFile? image) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _authRepository.update(user, image));
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    await _authRepository.logout();

    if (!state.hasError) {
      state = const AsyncData(
          User(id: "", email: "", username: "", profileImgPath: ""));
    }
  }
}
