import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/data/bill_repository.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';

import '../../group/states/groups_state.dart';

part 'bills_state.g.dart';

@Riverpod(keepAlive: true)
class BillsState extends _$BillsState {
  BillRepository get _billRepository => ref.read(billRepositoryProvider);

  @override
  Future<List<Bill>> build() {
    final user = ref.watch(authStateProvider).requireValue;
    return _getBillsByUser(user.id);
  }

  Future<List<Bill>> _getBillsByUser(String userId) async {
    return await _billRepository.getBillsByUser(userId);
  }

  Future<bool> add(Bill bill) async {
    final success = await _billRepository.create(bill);
    if (success) {
      ref.invalidate(groupStateProvider(bill.groupId));
      ref.invalidate(groupsStateProvider);
      ref.invalidateSelf();
    }
    return success;
  }
}
