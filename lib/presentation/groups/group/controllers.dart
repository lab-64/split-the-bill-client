import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';

part 'controllers.g.dart';

@riverpod
class GroupBillsController extends _$GroupBillsController {
  @override
  Future<List<Bill>> build(String groupId) async {
    final group = await ref.watch(groupStateProvider(groupId).future);
    return group.bills;
  }
}
