import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';

part 'controllers.g.dart';

@Riverpod(keepAlive: true)
class NewGroupController extends _$NewGroupController {
  @override
  FutureOr<bool> build() async {
    return false;
  }

  Future<void> addGroup(String groupName) async {
    state = const AsyncLoading();
    final user = ref.watch(authStateProvider).requireValue;

    final group = Group(
      id: '',
      name: groupName,
      balance: 0,
      members: [user.id],
      bills: [],
      owner: user.id,
    );

    final groupsState = ref.read(groupsStateProvider.notifier);
    state = await AsyncValue.guard(() => groupsState.add(group));
  }
}