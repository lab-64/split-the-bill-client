import 'package:split_the_bill/models/user.dart';

import '../models/group.dart';

class DummyDataCalls {
  //TODO change to shared_preferences
  List<User> users = [
    User(0, 'user0', 'user0@mail.com'),
    User(1, 'user1', 'user1@mail.com'),
    User(2, 'user2', 'user2@mail.com'),
    User(3, 'user3', 'user3@mail.com')
  ];

  List<Group> groups = [
    Group(0, 'Group 0', [], [], -9),
    Group(1, 'Group 1', [], [], 67),
    Group(2, 'Group 2', [], [], 57),
    Group(3, 'Group 3', [], [], -34)
  ];

  List<Group> getAllGroups() {
    return groups;
  }

  Group getGroup(int index) {
    return groups[index];
  }
}
