import 'package:split_the_bill/models/user.dart';
import 'package:split_the_bill/models/bill_mapping.dart';

class Group {
  late int id;
  late String name;
  late List<User> members;
  late List<BillMapping> billMappings;
  late int userBalance; //TODO make a set

  Group(this.id, this.name, this.members, this.billMappings, this.userBalance);
}
