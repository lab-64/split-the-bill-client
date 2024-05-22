import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/data/auth_repository.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/infrastructure/shared_preferences.dart';

part 'auth_state.g.dart';

const _signedOutUser = User(
  id: "",
  email: "",
  username: "",
  profileImgPath: "",
  sessionCookie: "",
);

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  @override
  Future<User> build() {
    /// Get user from shared preferences
    final String userString = ref.read(sharedUtilityProvider).getUser();

    if (userString.isNotEmpty) {
      return Future.value(User.fromMap(json.decode(userString)));
    }

    return Future.value(_signedOutUser);
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    _authRepository.login(email, password).then((user) {
      /// Save user to shared preferences
      final String userString = json.encode(user.toMap());
      ref.read(sharedUtilityProvider).setUser(userString);

      state = AsyncData(user);
    }).catchError((error) {
      state = AsyncError(error, StackTrace.current);
    });
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() => _authRepository.register(email, password));
    if (!state.hasError) {
      login(email: email, password: password);
    }
  }

  Future<void> updateUser(User user, XFile? image) async {
    state = const AsyncLoading();

    _authRepository.update(user, image).then((user) {
      /// Set session cookie because it is not returned from the server when updating user
      user = user.copyWith(sessionCookie: state.requireValue.sessionCookie);

      state = AsyncData(user);
    }).catchError((error) {
      state = AsyncError(error, StackTrace.current);
    });
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    await _authRepository.logout();

    if (!state.hasError) {
      ref.read(sharedUtilityProvider).removeUser();
      state = const AsyncData(_signedOutUser);
    }
  }

  Future<void> manualLogout() async {
    ref.read(sharedUtilityProvider).removeUser();
    state = const AsyncData(_signedOutUser);
  }
}
