import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/data/auth_repository.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/infrastructure/shared_preferences.dart';

part 'auth_state.g.dart';

// unanathicated recognition provider

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

    return Future.value(const User(
      id: "",
      email: "",
      username: "",
      profileImgPath: "",
      sessionCookie: "",
    ));
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
      ref.read(sharedUtilityProvider).setAuthCookie(user.sessionCookie);

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
    // TODO: take current cookie
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _authRepository.update(user, image));
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    await _authRepository.logout();

    if (!state.hasError) {
      state = const AsyncData(
        User(
          id: "",
          email: "",
          username: "",
          profileImgPath: "",
          sessionCookie: "",
        ),
      );
    }
  }
}
