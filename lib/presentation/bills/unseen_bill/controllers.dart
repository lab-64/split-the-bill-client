import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/item_contribution.dart';

part 'controllers.g.dart';

@riverpod
class ItemsContributions extends _$ItemsContributions {
  @override
  List<ItemContribution> build(Bill bill) {
    final user = ref.watch(authStateProvider).requireValue;
    return bill.items.map((item) {
      final contributorsIds =
          item.contributors.map((contributor) => contributor.id).toList();
      final isContributing = contributorsIds.contains(user.id);

      return ItemContribution(
        contributed: isContributing,
        itemID: item.id,
      );
    }).toList();
  }

  void setItemContribution(String itemId, bool isContributing) {
    // Update item's contributors based on the contribution status
    final updatedContributions = state.map((contribution) {
      if (contribution.itemID == itemId) {
        return contribution.copyWith(contributed: isContributing);
      }
      return contribution;
    }).toList();

    state = updatedContributions;
  }
}
