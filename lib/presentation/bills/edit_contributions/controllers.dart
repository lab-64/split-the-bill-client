import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/domain/bill/bill.dart';

part 'controllers.g.dart';

@riverpod
class ItemsContributions extends _$ItemsContributions {
  @override
  Map<String, bool> build(Bill bill) {
    final user = ref.watch(authStateProvider).requireValue;
    return {
      for (var v in bill.items)
        v.id: v.contributors
            .map((contributor) => contributor.id)
            .toList()
            .contains(user.id)
    };
  }

  void setItemContribution(String itemId, bool isContributing) {
    // Update item's contributors based on the contribution status
    state[itemId] = isContributing;
  }
}
