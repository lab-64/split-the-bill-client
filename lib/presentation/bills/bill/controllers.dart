import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/domain/item/item.dart';

part 'controllers.g.dart';

@Riverpod(keepAlive: true)
class BillItemsController extends _$BillItemsController {
  @override
  Future<List<Item>> build(String billId) async {
    final bill = await ref.watch(billStateProvider(billId).future);
    return bill.items;
  }
}
