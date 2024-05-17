import 'package:split_the_bill/domain/group/transaction.dart';

class GroupTransaction {
  final String id;
  final String groupName;
  final DateTime date;
  final List<Transaction> transactions;

  GroupTransaction(this.id, this.groupName, this.date, this.transactions);
}
