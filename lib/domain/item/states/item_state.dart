import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/domain/item/data/item_repository.dart';

import '../item.dart';

part 'item_state.g.dart';

@Riverpod(keepAlive:true)
class ItemState extends _$ItemState{
  ItemRepository get _itemRepository => ref.read(itemRepositoryProvider);

  Future<Item> _getItem(String itemId) async {
    return await _itemRepository.getItem(itemId);
  }

  Future<bool> addItemToBill(Item item, String billId) async {
    final success = await _itemRepository.addItemToBill(item, billId);
    if(success) ref.invalidateSelf();
    return success;
  }

  Future<bool> deleteItemFromBill(String itemId, String billId) async{
    final success = await _itemRepository.deleteItemFromBill(itemId, billId);
    if(success) ref.invalidateSelf();
    return success;
  }

  @override
  Future<Item> build(String itemId){
    return _getItem(itemId);
  }
}
