import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/data/bill_api.dart';
import 'package:split_the_bill/domain/bill/data/remote_bill_repository.dart';
import 'package:split_the_bill/infrastructure/http_client.dart';

part 'bill_repository.g.dart';

abstract class BillRepository {
  Future<List<Bill>> getBillsByUser(String userId);

  Future<List<Bill>> getNotSeenBillsByUser(String userId,
      {bool isUnseen = true, bool isOwner = false});

  Future<Bill> getBill(String billId);

  Future<Bill> create(Bill bill);

  Future<Bill> edit(Bill bill, bool isViewed);

  Future<void> delete(String billId);
}

@Riverpod(keepAlive: true)
BillRepository billRepository(BillRepositoryRef ref) {
  return RemoteBillRepository(
    api: BillAPI(),
    client: ref.read(httpClientProvider),
  );
}
