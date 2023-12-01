import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/domain/item/data/fake_item_repository.dart';

import '../item.dart';

part 'item_repository.g.dart';

abstract class ItemRepository{
  Future<Item> getItem(String itemId);

  Future<List<Item>> getItemsFromBill(String billId);

  Future<bool> addItemToBill(Item item, String billId);

  Future<bool> deleteItemFromBill(String itemId, String billId);
}

@Riverpod(keepAlive: true)
ItemRepository itemRepository(ItemRepositoryRef ref) {
  // TODO: Replace with a real repository when it's available
  return FakeItemRepository();
}