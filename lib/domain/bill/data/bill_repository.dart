import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/data/fake_bill_repository.dart';

part 'bill_repository.g.dart';

abstract class BillRepository {
  Future<List<Bill>> getBillsByUser(String userId);

  Future<Bill> getBillById(String billId);

  Future<bool> create(Bill bill);
}

@Riverpod(keepAlive: true)
BillRepository billRepository(BillRepositoryRef ref) {
  // TODO: Replace with a real repository when it's available
  return FakeBillRepository();
}
