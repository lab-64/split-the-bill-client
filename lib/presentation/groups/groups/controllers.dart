import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';

part 'controllers.g.dart';

@Riverpod(keepAlive: true)
class InvitationController extends _$InvitationController {
  @override
  FutureOr<void> build() async {}

  Future<void> acceptInvitation(String invitationId) async {
    state = const AsyncLoading();

    final groupsState = ref.read(groupsStateProvider.notifier);
    state = await AsyncValue.guard(
      () => groupsState.acceptInvitation(invitationId),
    );
  }
}
