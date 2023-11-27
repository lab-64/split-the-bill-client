import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';

part 'controllers.g.dart';

@riverpod
double groupsTotalBalance(GroupsTotalBalanceRef ref) {
  final groups = ref.watch(groupsStateProvider).value;
  return groups?.fold(0.0, (acc, group) => acc! + group.balance) ?? 0;
}

@riverpod
double groupBalance(GroupBalanceRef ref, String groupId) {
  final group = ref.watch(groupStateProvider(groupId)).value;
  return group?.bills.fold(0.0, (acc, bill) => acc! + bill.price) ?? 0;
}
