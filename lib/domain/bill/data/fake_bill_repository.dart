import 'package:split_the_bill/constants/test_data.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/data/bill_repository.dart';

class FakeBillRepository extends BillRepository {
  @override
  Future<List<Bill>> getBillsByUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return testBills
        .where((bill) =>
            bill.items.any((item) => item.contributors.contains(userId)))
        .toList();
  }

  @override
  Future<bool> add(Bill bill) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // This code is total garbage and is here just for testing purposes, don't repeat this at home XD

    try {
      var lastId = int.parse(testBills.last.id);
      bill = bill.copyWith(id: (lastId + 1).toString());

      testBills.add(bill);

      var group =
          testGroups.firstWhere((element) => element.id == bill.groupId);
      var bills = [...group.bills];
      bills.add(bill);

      var updatedGroup =
          group.copyWith(bills: bills, balance: group.balance + bill.price);

      var index = testGroups.indexWhere((element) => element.id == group.id);
      testGroups[index] = updatedGroup;
    } catch (e) {
      print(e);
    }

    return true;
  }
}
