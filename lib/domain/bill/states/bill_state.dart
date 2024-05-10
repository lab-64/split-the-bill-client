import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/data/bill_repository.dart';

import '../item.dart';

part 'bill_state.g.dart';

@riverpod
class BillState extends _$BillState {
  BillRepository get _billRepository => ref.read(billRepositoryProvider);

  Future<Bill> _getBill(String billId) async {
    return await _billRepository.getBill(billId);
  }

  Future<void> editItem(Item item) async {
    await _billRepository.editItem(item);
  }

  @override
  Future<Bill> build(String billId) {
    if (billId == '0') {
      return Future.value(Bill.getDefault());
    } else {
      return _getBill(billId);
    }
  }
}
