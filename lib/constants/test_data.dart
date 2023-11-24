import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/group/group.dart';

/// Test products to be used until a data source is implemented
final testGroups = [
  Group(
    id: '1',
    name: "Wohnung",
    balance: testBills[0].price + testBills[1].price,
    members: ["1", "2"],
    owner: "1",
    bills: [testBills[0], testBills[1]],
  ),
  Group(
    id: '2',
    name: "Urlaub",
    balance: testBills[2].price + testBills[3].price + testBills[4].price,
    members: ["1", "2", "5"],
    owner: "1",
    bills: [testBills[2], testBills[3], testBills[4]],
  ),
  Group(
    id: '3',
    name: "Shit",
    balance: 0.00,
    members: ["1", "2", "3"],
    owner: "1",
    bills: [],
  ),
  Group(
    id: '4',
    name: "Blalbleerrrrskere",
    balance: 0.00,
    members: ["1", "4", "5"],
    owner: "1",
    bills: [],
  ),
  Group(
    id: '5',
    name: "Party",
    balance: 0.00,
    members: ["1", "2", "5"],
    owner: "1",
    bills: [],
  ),
];

final testUsers = [
  User(
    id: '1',
    username: "Marvin",
    email: "hoho@go.com",
  ),
  User(
    id: '2',
    username: "Felix",
    email: "hoho@go.com",
  ),
  User(
    id: '3',
    username: "Jannis",
    email: "hoho@go.com",
  ),
  User(
    id: '4',
    username: "Grzegi",
    email: "hoho@go.com",
  ),
  User(
    id: '5',
    username: "Jan",
    email: "hoho@go.com",
  ),
];

final testBills = [
  Bill(
    id: '1',
    name: "Furniture",
    date: DateTime(2022, 11, 7),
    groupId: "1",
    ownerId: "1",
    contributors: ["1", "2"],
    price: 199.99,
  ),
  Bill(
    id: '2',
    name: "Rent",
    date: DateTime(2022, 11, 14),
    groupId: "1",
    ownerId: "2",
    contributors: ["1", "2"],
    price: 850,
  ),
  Bill(
    id: '3',
    name: "Alk",
    date: DateTime(2022, 09, 15),
    groupId: "2",
    ownerId: "1",
    contributors: ["1", "2"],
    price: 43.45,
  ),
  Bill(
    id: '4',
    name: "Hotel",
    date: DateTime(2022, 09, 17),
    groupId: "2",
    ownerId: "2",
    contributors: ["1", "2", "5"],
    price: 160,
  ),
  Bill(
    id: '5',
    name: "Auto",
    date: DateTime(2022, 09, 18),
    groupId: "2",
    ownerId: "5",
    contributors: ["2", "5"],
    price: 50,
  ),
];
