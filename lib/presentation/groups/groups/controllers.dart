import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'controllers.g.dart';

@riverpod
double groupsTotalBalance(GroupsTotalBalanceRef ref) {
  // TODO: implement or maybe remove
  //final groups = ref.watch(groupsStateProvider).value;
  //return groups?.fold(0.0, (acc, group) => acc! + group.balance) ?? 0;
  return 0;
}

@riverpod
double groupBalance(GroupBalanceRef ref, String groupId) {
  // TODO: implement or maybe remove
  //final group = ref.watch(groupStateProvider(groupId)).value;
  //return group?.bills.fold(0.0, (acc, bill) => acc! + bill.price) ?? 0;
  return 0;
}
