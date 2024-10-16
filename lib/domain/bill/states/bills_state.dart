import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/data/bill_repository.dart';
import 'package:split_the_bill/domain/bill/item_contribution.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';

part 'bills_state.g.dart';

@riverpod
class BillsState extends _$BillsState {
  BillRepository get _billRepository => ref.read(billRepositoryProvider);

  @override
  Future<List<Bill>> build({bool isUnseen = false}) {
    final user = ref.watch(authStateProvider).requireValue;
    return _getBillsByUser(user.id, isUnseen);
  }

  Future<List<Bill>> _getBillsByUser(String userId, bool isUnseen) async {
    return await _billRepository.getBillsByUser(userId, isUnseen: isUnseen);
  }

  Future<void> create(Bill bill) async {
    final newBill = await _billRepository.create(bill);
    final previousState = await future;
    state = AsyncData([...previousState, newBill]);

    ref.invalidate(groupStateProvider(newBill.groupId));
    ref.invalidate(groupsStateProvider);
  }

  Future<void> edit(Bill bill) async {
    final updatedBill = await _billRepository.edit(bill);
    final previousState = await future;
    state = AsyncData([...previousState, updatedBill]);

    ref.invalidate(groupStateProvider(updatedBill.groupId));
    ref.invalidate(groupsStateProvider);
    ref.invalidate(billStateProvider(updatedBill.id));
  }

  Future<void> updateContributions(
    String billId,
    List<ItemContribution> contributions,
  ) async {
    await _billRepository.updateContributions(billId, contributions);
  }

  Future<void> delete(Bill bill) async {
    await _billRepository.delete(bill.id);
    ref.invalidate(groupStateProvider(bill.groupId));
    ref.invalidate(groupsStateProvider);

    // Wait for the ref to be computed
    await future;
  }
}
