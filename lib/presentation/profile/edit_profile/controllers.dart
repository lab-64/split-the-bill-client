import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';

part 'controllers.g.dart';

@Riverpod(keepAlive: true)
class EditProfileController extends _$EditProfileController {
  @override
  FutureOr<void> build() async {}

  Future<void> updateUser(String username, XFile? image) async {
    state = const AsyncLoading();
    final user = ref.watch(authStateProvider).requireValue;
    final updatedUser = user.copyWith(username: username);

    final authState = ref.read(authStateProvider.notifier);
    state =
        await AsyncValue.guard(() => authState.updateUser(updatedUser, image));
  }
}
