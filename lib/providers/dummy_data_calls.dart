import 'package:split_the_bill/models/assignedItem.dart';
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
      User(0, 'user0', 'user0@mail.com'),
      User(1, 'user1', 'user1@mail.com'),
      User(2, 'user2', 'user2@mail.com'),
      User(3, 'user3', 'user3@mail.com')
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
      Bill(0, 'bill 0', DateTime.now(), [items[0], items[3]], 50),
      Bill(1, 'bill 1', DateTime.now(), [items[1], items[4]], 70),
      Bill(2, 'bill 2', DateTime.now(), [items[3], items[6], items[4]], 160)
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
    return groups[index];
  }

  void overwriteGroup(Group group) {
    groups[group.id] = group;
  }

  void saveNewGroup(Group group) {
    Group newGroup = group;
    newGroup.id = groups.length;
    groups.add(newGroup);
  }
}