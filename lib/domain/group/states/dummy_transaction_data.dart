import '../../../auth/user.dart';
import '../group_transaction.dart';
import '../transaction.dart';

class DummyTransactionData {
  final data = [
    GroupTransaction('0', 'Some group Name', DateTime(2017, 8, 14, 12), [
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user2@web.de',
              username: 'user2',
              profileImgPath: ''),
          1.00),
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user2@web.de',
              username: 'user2',
              profileImgPath: ''),
          1.00),
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user2@web.de',
              username: 'user2',
              profileImgPath: ''),
          1.00),
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user2@web.de',
              username: 'user2',
              profileImgPath: ''),
          1.00),
    ]),
    GroupTransaction('1', 'Some group Name 2', DateTime.now(), [
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '3',
              email: 'user3@web.de',
              username: 'user3',
              profileImgPath: ''),
          5.00),
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '3',
              email: 'user3@web.de',
              username: 'user3',
              profileImgPath: ''),
          5.00),
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '3',
              email: 'user3@web.de',
              username: 'user3',
              profileImgPath: ''),
          5.00),
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '3',
              email: 'user3@web.de',
              username: 'user3',
              profileImgPath: ''),
          5.00),
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '3',
              email: 'user3@web.de',
              username: 'user3',
              profileImgPath: ''),
          5.00),
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '3',
              email: 'user3@web.de',
              username: 'user3',
              profileImgPath: ''),
          5.00),
    ]),
    GroupTransaction('2', 'Some group Name 3', DateTime(2017, 1, 14, 12), [
      Transaction(
          const User(
              id: '3',
              email: 'user3@web.de',
              username: 'user3',
              profileImgPath: ''),
          const User(
              id: '0',
              email: 'user0@web.de',
              username: 'user0',
              profileImgPath: ''),
          10.00),
      Transaction(
          const User(
              id: '3',
              email: 'user3@web.de',
              username: 'user3',
              profileImgPath: ''),
          const User(
              id: '0',
              email: 'user0@web.de',
              username: 'user0',
              profileImgPath: ''),
          10.00),
      Transaction(
          const User(
              id: '3',
              email: 'user3@web.de',
              username: 'user3',
              profileImgPath: ''),
          const User(
              id: '0',
              email: 'user0@web.de',
              username: 'user0',
              profileImgPath: ''),
          10.00),
    ]),
    GroupTransaction('3', 'Some group Name 4', DateTime.now(), [
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          20.00),
    ]),
    GroupTransaction('4', 'Some group Name 2', DateTime(2017, 5, 14, 12), [
      Transaction(
          const User(
              id: '3',
              email: 'user3@web.de',
              username: 'user3',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          40.00),
      Transaction(
          const User(
              id: '3',
              email: 'user3@web.de',
              username: 'user3',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          40.00),
    ]),
    GroupTransaction('5', 'Some group Name', DateTime.now(), [
      Transaction(
          const User(
              id: '1',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '0',
              email: 'user0@web.de',
              username: 'user0',
              profileImgPath: ''),
          80.00),
    ]),
    GroupTransaction('6', 'Some group Name 3', DateTime(2017, 3, 14, 12), [
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user2@web.de',
              username: 'user2',
              profileImgPath: ''),
          160.00),
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user2@web.de',
              username: 'user2',
              profileImgPath: ''),
          160.00),
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user2@web.de',
              username: 'user2',
              profileImgPath: ''),
          160.00),
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user2@web.de',
              username: 'user2',
              profileImgPath: ''),
          160.00),
    ]),
    GroupTransaction('7', 'Some group Name 2', DateTime.now(), [
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user2@web.de',
              username: 'user2',
              profileImgPath: ''),
          320.00),
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user2@web.de',
              username: 'user2',
              profileImgPath: ''),
          320.00),
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user2@web.de',
              username: 'user2',
              profileImgPath: ''),
          320.00),
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user2@web.de',
              username: 'user2',
              profileImgPath: ''),
          320.00),
    ]),
    GroupTransaction('8', 'Some group Name 2', DateTime(2017, 7, 14, 12), [
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user2@web.de',
              username: 'user2',
              profileImgPath: ''),
          640.00),
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user2@web.de',
              username: 'user2',
              profileImgPath: ''),
          640.00),
    ]),
    GroupTransaction('9', 'Some group Name 4', DateTime.now(), [
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user2@web.de',
              username: 'user2',
              profileImgPath: ''),
          1280.00),
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user2@web.de',
              username: 'user2',
              profileImgPath: ''),
          1280.00),
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user2@web.de',
              username: 'user2',
              profileImgPath: ''),
          1280.00),
      Transaction(
          const User(
              id: '0',
              email: 'user1@web.de',
              username: 'user1',
              profileImgPath: ''),
          const User(
              id: '1',
              email: 'user2@web.de',
              username: 'user2',
              profileImgPath: ''),
          1280.00),
    ]),
  ];
}
