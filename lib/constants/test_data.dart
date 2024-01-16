import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/group/group.dart';

import '../domain/item/item.dart';

/// Test products to be used until a data source is implemented
final testGroups = [
  Group(
    id: '1',
    name: "Wohnung",
    members: [testUsers[0], testUsers[1]],
    owner: testUsers[0],
    bills: [testBills[0], testBills[1]],
  ),
  Group(
    id: '2',
    name: "Urlaub",
    members: [testUsers[0], testUsers[1], testUsers[4]],
    owner: testUsers[0],
    bills: [testBills[2], testBills[3], testBills[4]],
  ),
  Group(
    id: '3',
    name: "Shit",
    members: [testUsers[0], testUsers[1], testUsers[2]],
    owner: testUsers[0],
    bills: [testBills[5]],
  ),
  Group(
    id: '4',
    name: "Blalbleerrrrskere",
    members: [testUsers[0], testUsers[3], testUsers[4]],
    owner: testUsers[0],
    bills: [],
  ),
  Group(
    id: '5',
    name: "Party",
    members: [testUsers[0], testUsers[1], testUsers[4]],
    owner: testUsers[0],
    bills: [],
  ),
];

final testUsers = [
  User(
    id: '1',
    email: "hoho@go.com",
  ),
  User(
    id: '2',
    email: "hoho@go.com",
  ),
  User(
    id: '3',
    email: "hoho@go.com",
  ),
  User(
    id: '4',
    email: "hoho@go.com",
  ),
  User(
    id: '5',
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
      items: [testItems[2], testItems[9]]),
  Bill(
      id: '2',
      name: "Rent",
      date: DateTime(2022, 11, 14),
      groupId: "1",
      ownerId: "2",
      items: [testItems[6]]),
  Bill(
      id: '3',
      name: "Alk",
      date: DateTime(2022, 09, 15),
      groupId: "2",
      ownerId: "1",
      items: [testItems[3], testItems[8]]),
  Bill(
      id: '4',
      name: "Hotel",
      date: DateTime(2022, 09, 17),
      groupId: "2",
      ownerId: "2",
      items: [testItems[7]]),
  Bill(
      id: '5',
      name: "Auto",
      date: DateTime(2022, 09, 18),
      groupId: "2",
      ownerId: "5",
      items: [testItems[5]]),
  Bill(
      id: '6',
      name: "Essen",
      date: DateTime(2022, 09, 18),
      groupId: "2",
      ownerId: "5",
      items: [testItems[0], testItems[1]]),
];

final testItems = [
  const Item(
      id: '1', name: 'Kartoffeln', price: 7.000, billId: '6', contributors: []),
  const Item(
      id: '2', name: 'Apfel', price: 5.0000, billId: '6', contributors: []),
  const Item(
      id: '3', name: 'Stuhl', price: 130.0000, billId: '1', contributors: []),
  const Item(
      id: '4', name: 'Wein', price: 1.20000, billId: '3', contributors: []),
  const Item(
      id: '5', name: 'Joghurt', price: 3.0000, billId: '6', contributors: []),
  const Item(id: '6', name: 'Auto', price: 600, billId: '5', contributors: []),
  const Item(
      id: '7', name: 'Miete', price: 450.67, billId: '2', contributors: []),
  const Item(
      id: '8', name: 'Hotel', price: 745.97, billId: '4', contributors: []),
  const Item(
      id: '9', name: 'Bier', price: 14.50, billId: '3', contributors: []),
  const Item(
      id: '10', name: 'Schrank', price: 780, billId: '1', contributors: []),
  const Item(
      id: '11', name: 'Orange', price: 7.80, billId: '6', contributors: []),
  const Item(
      id: '12', name: 'Haenchen', price: 15.98, billId: '6', contributors: []),
];
