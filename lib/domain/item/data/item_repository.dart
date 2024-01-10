import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/domain/item/data/fake_item_repository.dart';

import '../item.dart';

part 'item_repository.g.dart';

abstract class ItemRepository {
  Future<Item> getItem(String itemID);

  Future<List<Item>> getItemsFromBill(String billID);

  Future<bool> addItemToBill(Item item, String billID);

  Future<bool> deleteItemFromBill(String itemID, String billID);
}

@Riverpod(keepAlive: true)
ItemRepository itemRepository(ItemRepositoryRef ref) {
  // TODO: Replace with a real repository when it's available
  return FakeItemRepository();
}
