import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/domain/bill/data/bill_repository.dart';
import 'package:split_the_bill/domain/group/data/group_repository.dart';

import '../bill.dart';

part 'bill_state.g.dart';

@Riverpod(keepAlive: true)
class BillState extends _$BillState {
  BillRepository get _billRepository => ref.read(billRepositoryProvider);

  Future<Bill> _getBill(String billId) async {
    return await _billRepository.getBillById(billId);
  }

  @override
  Future<Bill> build(String billId) {
    return _getBill(billId);
  }
}
