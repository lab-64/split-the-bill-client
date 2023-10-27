import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_the_bill/models/assigned_item.dart';
import 'package:split_the_bill/models/bill.dart';
import 'package:split_the_bill/models/item.dart';
import 'package:split_the_bill/models/user.dart';

import '../models/bill_mapping.dart';
import '../models/group.dart';

class DummyDataCalls {
  //TODO change to shared_preferences
  late List<User> users;
  late List<Group> groups;
  late List<BillMapping> billMappings;
  late List<Bill> bills;
  late List<Item> items;

  DummyDataCalls() {
    users = [
      User(0, 'user0', 'user0@mail.com', 'user0'),
      User(1, 'user1', 'user1@mail.com', 'user1'),
      User(2, 'user2', 'user2@mail.com', 'user2'),
      User(3, 'user3', 'user3@mail.com', 'user3'),
      User(4, 'test', 'test', 'test')
    ];

    items = [
      Item(0, 'Item 0', 10),
      Item(1, 'Item 1', 20),
      Item(2, 'Item 2', 30),
      Item(3, 'Item 3', 40),
      Item(4, 'Item 4', 50),
      Item(5, 'Item 5', 60),
      Item(6, 'Item 6', 70),
      Item(7, 'Item 7', 80),
      AssignedItem(8, 'assigned Item 1', 23, users[0])
    ];

    bills = [
      Bill(0, 'bill 0', DateTime.now(), [items[0], items[3]]),
      Bill(1, 'bill 1', DateTime.now(), [items[1], items[4]]),
      Bill(2, 'bill 2', DateTime.now(), [items[3], items[6], items[4]])
    ];

    billMappings = [
      BillMapping(users[0], bills[0], [users[0], users[3]]),
      BillMapping(users[1], bills[2], [users[1], users[3]])
    ];

    groups = [
      Group(0, 'Group 0', [users[1], users[3]],
          [billMappings[0], billMappings[1]], -9),
      Group(1, 'Group 1', [users[1], users[2], users[3]], [], 67),
      Group(2, 'Group 2', [users[1]], [billMappings[1]], 57),
      Group(3, 'Group 3', [users[0], users[1], users[2], users[3]],
          [billMappings[0], billMappings[1]], -34)
    ];
  }

  List<Group> getAllGroups() {
    return groups;
  }

  Group getGroup(int index) {
    if (index >= groups.length || index < 0) {
      return Group(0, "new Group", [], [], 0);
    }
    return groups[index];
  }

  Future<void> addBillToGroup(int billId, int groupID) async {
    if (groupID < 0) {
      billMappings.add(BillMapping(
          await getUser(), getBill(billId), [])); //TODO change contributors
    } else {
      groups[groupID].billMappings.add(BillMapping(
          await getUser(), getBill(billId), [])); //TODO change contributors
    }
  }

  Future<List<Group>> getOwnGroups() async {
    print("getUsergroups");
    User user = await getUser();
    print(user.username);
    print(
        groups.where((group) => group.members.contains(user)).toList().length);
    return groups.where((group) => group.members.contains(user)).toList();
  }

  void updateBillInGroup(int billId, int groupID) {
    Group group = getGroup(groupID);
    int index =
        group.billMappings.indexWhere((element) => element.bill.id == billId);
    group.billMappings[index].bill = bills[billId];
  }

  void overwriteGroup(Group group) {
    groups[group.id] = group;
  }

  void saveNewGroup(Group group) async {
    Group newGroup = group;
    newGroup.members.add(await getUser());
    newGroup.id = groups.length;
    groups.add(newGroup);
  }

  Bill getBill(int billId) {
    if (billId >= bills.length || billId < 0) {
      return Bill(-1, "new Bill", DateTime.now(), []);
    }
    return bills[billId];
  }

  void overwriteBill(Bill bill) {
    bills[bill.id] = bill;
  }

  void saveNewBill(Bill bill) {
    Bill newBill = bill;
    newBill.id = bills.length;
    bills.add(newBill);
    billMappings
        .add(BillMapping(users[0], newBill, [])); //TODO change to actual user
  }

  List<BillMapping> getOwnBills() {
    User user = users[0]; //TODO change to real user
    return billMappings
        .where((element) => element.owner.username == user.username)
        .toList();
  }

  void changeBillFromTo(int billId, int fromGroupId, int toGroupId) {
    int index = groups[fromGroupId]
        .billMappings
        .indexWhere((element) => element.bill.id == billId);
    BillMapping bill = groups[fromGroupId].billMappings.removeAt(index);
    groups[toGroupId].billMappings.add(bill);
  }

  int getGroupIDOfBill(int billId) {
    return groups.indexWhere((group) =>
        group.billMappings.map((mapping) => mapping.bill.id).contains(billId));
  }

  Item getItem(int itemId) {
    return itemId < 0
        ? Item(-1, "new Item", 0)
        : items.singleWhere((item) => item.id == itemId);
  }

  void overwriteItem(Item item) {
    items[item.id] = item;
  }

  void deleteItem(int itemId) {
    //TODO change to actual delete
    items.where((element) => element.id == itemId).first.price = 0.0;
  }

  ///----------------User authentication--------------------

  bool login(String username, String password) {
    if (users.where((user) => user.username == username).isNotEmpty) {
      setUserInPrefs(username);
      return true;
    }
    return false;
  }

  setUserInPrefs(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('username') != null) {
      return users
          .where((user) => user.username == prefs.getString('username'))
          .toList()[0];
    } else {
      return User(-1, 'no name', 'no email', 'no password');
    }
  }

  register(String username, String email, String password) async {
    setUserInPrefs(username);
    users.add(User(users.length, username, email, password));
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('email');
    prefs.remove('password');
  }
}
