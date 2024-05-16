import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/data/auth_repository.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/infrastructure/shared_preferences.dart';

part 'auth_state.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  // isLoggedIn = user set
  // isAuth = cookie from last response = cookie in storage
  // Session has to be deleted, i can read from shared preferences instead

  bool get isAuth => state.requireValue.id.isNotEmpty;

  @override
  FutureOr<User> build() {
    final String userString = ref.read(sharedUtilityProvider).getUser();
    print("BUILD: $userString");

    if (userString.isNotEmpty) {
      return User.fromMap(json.decode(userString));
    }
    return const User(id: "", email: "", username: "", profileImgPath: "");
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    _authRepository.login(email, password).then((user) {
      // that'S ok i guess
      final String userString = json.encode(user.toMap());
      ref.read(sharedUtilityProvider).setUser(userString);

      state = AsyncData(user);
    }).catchError((error) {
      state = AsyncError(error, StackTrace.current);
    });

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
