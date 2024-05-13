import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/data/bill_api.dart';
import 'package:split_the_bill/domain/bill/data/bill_repository.dart';
import 'package:split_the_bill/domain/bill/item.dart';
import 'package:split_the_bill/infrastructure/http_client.dart';

class RemoteBillRepository extends BillRepository {
  RemoteBillRepository({required this.api, required this.client});

  final BillAPI api;
  final HttpClient client;

  @override
  Future<Bill> edit(Bill bill) {
    return client.put(
      uri: api.updateBill(bill.id),
      body: bill.toMap(),
      builder: (data) => Bill.fromMap(data),
    );
  }

  @override
  Future<Bill> getBill(String billId) => client.get(
        uri: api.getBill(billId),
        builder: (data) => Bill.fromMap(data),
      );

  @override
  Future<Bill> create(Bill bill) => client.post(
        uri: api.createBill(),
        body: bill.toMap(),
        builder: (data) => Bill.fromMap(data),
      );

  @override
  Future<void> delete(String billId) =>
      client.delete(uri: api.deleteBill(billId));

  @override
  Future<List<Bill>> getBillsByUser(
    String userId, {
    bool isUnseen = false,
    bool isOwner = false,
  }) =>
      client.get(
        uri: api.getBillByUser(userId, isUnseen, isOwner),
        builder: (data) => data?.isNotEmpty == true
            ? data.map((bills) => Bill.fromMap(bills)).toList().cast<Bill>()
            : [],
      );

  @override
  Future<Item> editItem(Item item) {
    return client.put(
      uri: api.editItem(item.id),
      body: item.toMap(),
      builder: (data) => Item.fromMap(data),
    );
  }
}
