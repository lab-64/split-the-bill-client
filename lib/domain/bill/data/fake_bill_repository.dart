import 'package:split_the_bill/constants/test_data.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/data/bill_repository.dart';

import '../../../infrastructure/app_exception.dart';

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

  @override
  Future<bool> edit(Bill bill) async {
    print("FAKE BILL REPOSITORY");
    print("BILL ID: " + bill.id);
    print("BILL NAME: " + bill.name);

    for(var bill in testBills){
      print(bill.name);
      print(bill.id);
    }

    await Future.delayed(const Duration(milliseconds: 200));
    try {
      var billIndex = testBills.indexWhere((element) => element.id == bill.id);
      testBills[billIndex] = bill;
      var group =
          testGroups.firstWhere((element) => element.id == bill.groupId);

      var bills = [...group.bills];
      var groupIndex = bills.indexWhere((element) => element.id == bill.id);
      bills[groupIndex] = bill;


      var updatedGroup =
          group.copyWith(bills: bills, balance: group.balance + bill.price);

      var index = testGroups.indexWhere((element) => element.id == group.id);
      testGroups[index] = updatedGroup;
    } catch (e) {
      print(e);
    }
    print("--------");
    for(var bill in testBills){
      print(bill.name);
      print(bill.id);
    }
    return true;
  }

  @override
  Future<Bill> getBillById(String billId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final bill = testBills.where((bill) => bill.id == billId).first;
    if (bill == null) throw ItemNotFoundException();
    return bill;
  }
}
