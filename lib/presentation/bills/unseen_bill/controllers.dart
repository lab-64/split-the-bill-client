import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/domain/bill/item.dart';

part 'controllers.g.dart';

@riverpod
class ItemsContributions extends _$ItemsContributions {
  @override
  List<Item> build() {
    return [];
  }

  void setItemContribution(Item item) {
    // Add item if it doesn't exist
    if (!state.any((e) => e.id == item.id)) {
      state = [...state, item];
    }

    // Update the state with item
    state = state.map((e) {
      if (e.id == item.id) {
        return item;
      }
      return e;
    }).toList();
  }
}
