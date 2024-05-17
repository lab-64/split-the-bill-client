import '../../auth/user.dart';

class Transaction {
  final User debtor;
  final User creditor;
  final double amount;

  Transaction(this.debtor, this.creditor, this.amount);
}
