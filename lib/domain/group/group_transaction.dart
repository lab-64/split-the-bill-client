import 'package:split_the_bill/domain/group/transaction.dart';

class GroupTransaction {
  final String id;
  final String groupName;
  final DateTime date;
  final List<Transaction> transactions;

//<editor-fold desc="Data Methods">
  const GroupTransaction({
    required this.id,
    required this.groupName,
    required this.date,
    required this.transactions,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupTransaction &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          groupName == other.groupName &&
          date == other.date &&
          transactions == other.transactions);

  @override
  int get hashCode =>
      id.hashCode ^ groupName.hashCode ^ date.hashCode ^ transactions.hashCode;

  @override
  String toString() {
    return 'GroupTransaction{ id: $id, groupName: $groupName, date: $date, transactions: $transactions,}';
  }

  GroupTransaction copyWith({
    String? id,
    String? groupName,
    DateTime? date,
    List<Transaction>? transactions,
  }) {
    return GroupTransaction(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      date: date ?? this.date,
      transactions: transactions ?? this.transactions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groupName': groupName,
      'date': '${date.toIso8601String().split('.')[0]}Z',
      'transactions': transactions.map((transaction) => transaction.toMap()),
    };
  }

  factory GroupTransaction.fromMap(Map<String, dynamic> map) {
    return GroupTransaction(
      id: map['id'] as String,
      groupName: map['groupName'] as String,
      date: DateTime.parse(map['date']),
      transactions: (map['transactions'] as List<dynamic>)
          .map((item) => Transaction.fromMap(item))
          .toList(),
    );
  }

//</editor-fold>
}
