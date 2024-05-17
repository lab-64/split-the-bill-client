import '../../auth/user.dart';

class Transaction {
  final User debtor;
  final User creditor;
  final double amount;

//<editor-fold desc="Data Methods">
  const Transaction({
    required this.debtor,
    required this.creditor,
    required this.amount,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          runtimeType == other.runtimeType &&
          debtor == other.debtor &&
          creditor == other.creditor &&
          amount == other.amount);

  @override
  int get hashCode => debtor.hashCode ^ creditor.hashCode ^ amount.hashCode;

  @override
  String toString() {
    return 'Transaction{ debtor: $debtor, creditor: $creditor, amount: $amount,}';
  }

  Transaction copyWith({
    User? debtor,
    User? creditor,
    double? amount,
  }) {
    return Transaction(
      debtor: debtor ?? this.debtor,
      creditor: creditor ?? this.creditor,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'debtorId': debtor.id,
      'creditorId': creditor.id,
      'amount': amount,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      debtor: User.fromMap(map['debtor']),
      creditor: User.fromMap(map['creditor']),
      amount: (map['amount'] is int)
          ? (map['amount'] as int).toDouble()
          : map['amount'] as double,
    );
  }

//</editor-fold>
}
