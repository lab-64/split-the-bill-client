import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';
import 'package:split_the_bill/domain/item/item.dart';

part 'controllers.g.dart';

@Riverpod(keepAlive: true)
class EditBillController extends _$EditBillController {
  @override
  FutureOr<void> build() async {}

  Future<void> addBill(String groupId, List<Item> items) async {
    state = const AsyncLoading();
    final user = ref.watch(authStateProvider).value;

    final bill = Bill(
      id: '',
      name: items.first.name,
      groupId: groupId,
      ownerId: user!.id,
      date: DateTime.now(),
      items: items,
    );

    final billsState = ref.read(billsStateProvider.notifier);
    state = await AsyncValue.guard(() => billsState.create(bill));
  }

  Future<void> editBill(Bill bill, List<Item> items) async {
    state = const AsyncLoading();
    Bill updatedBill = bill.copyWith(items: items);

    final billsState = ref.read(billsStateProvider.notifier);
    state = await AsyncValue.guard(() => billsState.edit(updatedBill));
  }
}
