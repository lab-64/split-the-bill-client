import 'package:split_the_bill/models/bill.dart';
import 'package:split_the_bill/models/user.dart';

class BillMapping {
  late User owner;
  late Bill bill;
  late List<User> contributors;

  BillMapping(this.owner, this.bill, this.contributors);
}
