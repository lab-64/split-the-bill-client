import 'package:split_the_bill/domain/item/data/item_repository.dart';
import 'package:split_the_bill/domain/item/item.dart';

class RemoteItemRepository extends ItemRepository{

  @override
  Future<bool> addItemToBill(Item item, String billID) {
    // TODO: implement addItemToBill
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteItemFromBill(String itemID, String billID) {
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