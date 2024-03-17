import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/item.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';

part 'controllers.g.dart';

@Riverpod(keepAlive: true)
class EditBillController extends _$EditBillController {
  @override
  FutureOr<void> build() async {}

  Future<void> addBill(String groupId) async {
    state = const AsyncLoading();
    final user = ref.watch(authStateProvider).requireValue;
    final items = ref.read(itemsProvider('0'));

    final bill = Bill(
      id: '',
      name: items.first.name,
      groupId: groupId,
      owner: user,
      date: DateTime.now(),
      items: items,
      balance: {},
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

@riverpod
class Items extends _$Items {
  @override
  List<Item> build(String billId) {
    return ref.read(billStateProvider(billId)).requireValue.items;
  }

  void addItem(Item item) {
    state = [...state, item];
  }

  void updateItem(int index, String name, String price) {
    state[index] = state[index].copyWith(
      name: name,
      price: double.parse(price),
    );
  }

  void removeItem(int index) {
    state.removeAt(index);
  }
}
