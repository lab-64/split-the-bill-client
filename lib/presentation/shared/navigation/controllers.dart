import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';

part 'controllers.g.dart';

@Riverpod(keepAlive: true)
class NavbarController extends _$NavbarController {
  @override
  int build() {
    return 0;
  }

  void setIndex(int index) {
    state = index;
  }
}
