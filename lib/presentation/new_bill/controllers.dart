import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';

part 'controllers.g.dart';

@Riverpod(keepAlive: true)
class NewBillController extends _$NewBillController {
  @override
  FutureOr<bool> build() async {
    return false;
  }

  Future<void> addBill(String billName, String price, String groupId) async {
    state = const AsyncLoading();
    final user = ref.watch(authStateProvider).value;

    final bill = Bill(
      id: '',
      name: billName,
      groupId: groupId,
      ownerId: user!.id,
      date: DateTime.now(),
      price: double.parse(price),
      items: []
    );

    final billState = ref.read(billsStateProvider.notifier);
    state = await AsyncValue.guard(() => billState.add(bill));
  }
}
