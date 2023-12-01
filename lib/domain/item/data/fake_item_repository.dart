import 'package:split_the_bill/domain/item/data/item_repository.dart';
import 'package:split_the_bill/domain/item/item.dart';

import '../item.dart';


class FakeItemRepository extends ItemRepository{
  @override
  Future<bool> addItemToBill(Item item, String billId) {
    // TODO: implement addItemToBill
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteItemFromBill(String itemId, String billId) {
    // TODO: implement deleteItemFromBill
    throw UnimplementedError();
  }

  @override
  Future<Item> getItem(String itemId) {
    // TODO: implement getItem
    throw UnimplementedError();
  }

  @override
  Future<List<Item>> getItemsFromBill(String billId) {
    // TODO: implement getItemsFromBill
    throw UnimplementedError();
  }

}