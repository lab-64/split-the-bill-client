import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/item.dart';

part 'controllers.g.dart';

@riverpod
class ItemsContributions extends _$ItemsContributions {
  @override
  List<Item> build(Bill bill) {
    return bill.items;
  }

  bool isUserContributingToItem(Item item) {
    final user = ref.watch(authStateProvider).requireValue;

    // Check if any contributor of the item matches the current user
    return state.any(
      (e) => e.id == item.id && e.contributors.any((e) => e.id == user.id),
    );
  }

  void setItemContribution(int index, bool isContributing) {
    final user = ref.watch(authStateProvider).requireValue;

    // Update item's contributors based on the contribution status
    if (isContributing) {
      if (!state[index].contributors.any((e) => e.id == user.id)) {
        // Add user to contributors if not already present
        state[index] = state[index].copyWith(contributors: [
          ...state[index].contributors,
          user,
        ]);
      }
    } else {
      // Remove user from contributors
      state[index] = state[index].copyWith(
        contributors: [
          ...state[index].contributors.where((e) => e.id != user.id),
        ],
      );
    }
  }
}
