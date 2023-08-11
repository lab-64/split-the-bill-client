import 'package:split_the_bill/models/user.dart';
import 'package:split_the_bill/models/bill_mapping.dart';

class Group {
  late int id;
  late List<User> members;
  late List<BillMapping> billMappings;
  late List<int> userBalance;

  Group(this.id, this.members, this.billMappings, this.userBalance);
}
