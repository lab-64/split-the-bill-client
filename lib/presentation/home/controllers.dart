import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';

part 'controllers.g.dart';

@riverpod
double userTotalBalance(UserTotalBalanceRef ref) {
  final user = ref.watch(authStateProvider).requireValue;
  final groups = ref.watch(groupsStateProvider);

  double totalBalance = 0.0;

  if (groups.hasValue) {
    for (var group in groups.requireValue) {
      if (group.balance.containsKey(user.id)) {
        totalBalance += group.balance[user.id] ?? 0.0;
      }
    }
  }

  return totalBalance;
}
