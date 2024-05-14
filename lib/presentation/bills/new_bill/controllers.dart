import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/item.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';

part 'controllers.g.dart';

@Riverpod(keepAlive: true)
class EditBillController extends _$EditBillController {
  late String _name;
  late DateTime _date;

  @override
  FutureOr<void> build() async {
    _name = '';
    _date = DateTime.now();
  }

  void setName(String name) => _name = name;

  void setDate(DateTime date) => _date = date;

  Future<void> addBill(String groupId) async {
    state = const AsyncLoading();
    final user = ref.watch(authStateProvider).requireValue;
    final items = ref.read(itemsProvider('0'));

    final bill = Bill(
      id: '',
      name: _name == '' ? items.first.name : _name,
      groupId: groupId,
      owner: user,
      date: _date,
      items: items,
      balance: {},
      isViewed: true,
    );

    for (var item in bill.items) {
      if (item.name == "" || item.price == 0.0) {
        state = AsyncError(
            "Please give all items a name and a price other than 0.0€!",
            StackTrace.current);
        return;
      }
    }

    final billsState = ref.read(billsStateProvider().notifier);
    state = await AsyncValue.guard(() => billsState.create(bill));
  }

  Future<void> editBill(Bill bill, List<Item> items) async {
    state = const AsyncLoading();
    Bill updatedBill = bill.copyWith(items: items);

    final billsState = ref.read(billsStateProvider().notifier);
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

  void updateItem(
    int index,
    String name,
    String price,
    List<User> contributors,
  ) {
    state[index] = state[index].copyWith(
      name: name,
      price: price.isEmpty ? 0 : double.parse(price),
      contributors: contributors,
    );
  }

  void removeItem(int index) {
    state.removeAt(index);
  }
}
