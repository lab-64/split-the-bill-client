import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/domain/user/data/user_repository.dart';

part 'controllers.g.dart';

@Riverpod(keepAlive: true)
class EditProfileController extends _$EditProfileController {
  @override
  FutureOr<void> build() async {}

  Future<void> updateUser(String username) async {
    state = const AsyncLoading();
    final user = ref.watch(authStateProvider).requireValue;
    final updatedUser = user.copyWith(username: username);
    final userRepository = ref.read(userRepositoryProvider);
    state = await AsyncValue.guard(() => userRepository.update(updatedUser));

    ref.invalidate(authStateProvider);
  }
}
