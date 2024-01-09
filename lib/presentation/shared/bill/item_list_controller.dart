import 'package:flutter/material.dart';

import '../../../domain/item/item.dart';
import 'item_container.dart';

class ItemListController {
  final List<TextEditingController> _names = [];
  final List<TextEditingController> _prices = [];
  final List<ItemContainer> _items = [];
  Function updateListView = () => {};


  void setUpdateListView(Function newUpdateListView) {
    updateListView = newUpdateListView;
  }

  void dispose() {
    _names.map((e) => e.dispose());
    _prices.map((e) => e.dispose());
  }

  void addNewItem() {
    _names.add(TextEditingController());
    _prices.add(TextEditingController());
    _items.add(ItemContainer(
      name: _names.last,
      price: _prices.last,
      index: _items.length,
      deleteSelf: deleteItem,
      onChanged: onChange,
    ));
    updateListView();
  }

  void addExistingItem(Item item) {
    _names.add(TextEditingController(text: item.name));
    _prices.add(TextEditingController(text: item.price.toString()));
    _items.add(ItemContainer(
        name: _names.last,
        price: _prices.last,
        index: _items.length,
        deleteSelf: deleteItem,
        onChanged: onChange));
    updateListView();
  }

  void deleteItem(int index) {
    if (_items.length > 1) {
      _items.removeAt(index);
      _names.removeAt(index);
      _prices.removeAt(index);

      //update itemContainers with new index
      for (var i = 0; i < _items.length; i++) {
        _items[i] = ItemContainer(
            name: _names[i],
            price: _prices[i],
            index: i,
            deleteSelf: deleteItem,
            onChanged: onChange);
      }
    }
    updateListView();
  }

  void onChange(String value, bool name, int index) {
    if (name) {
      _names[index].text = value;
    } else {
      _prices[index].text = value;
    }
  }

  TextEditingController getName(int index) {
    return _names[index];
  }

  TextEditingController getPrice(int index) {
    return _prices[index];
  }

  ItemContainer getItemContainer(int index) {
    return _items[index];
  }

  List<TextEditingController> getNames() {
    return _names;
  }

  List<TextEditingController> getPrices() {
    return _prices;
  }

  List<ItemContainer> getItems() {
    return _items;
  }
}
