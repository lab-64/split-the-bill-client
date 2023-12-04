import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/domain/item/data/item_repository.dart';
import '../item.dart';

part 'items_state.g.dart';

@Riverpod(keepAlive:true)
class ItemsState extends _$ItemsState {
  ItemRepository get _itemRepository => ref.read(itemRepositoryProvider);

  @override
  Future<List<Item>> build() {
    String billId = "";
    return _getItemByBill(billId);
  }

  Future<List<Item>> _getItemByBill(String billId) async {
    return await _itemRepository.getItemsFromBill(billId);
  }
}