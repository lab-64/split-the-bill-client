import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';

import '../../domain/group/group_transaction.dart';

part 'controllers.g.dart';

@Riverpod(keepAlive: true)
class TransactionsController extends _$TransactionsController {
  @override
  Future<List<GroupTransaction>> build() async {
    return ref.read(groupsStateProvider.notifier).getAllTransactions();
  }
}
