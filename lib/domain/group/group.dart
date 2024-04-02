import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/domain/bill/bill.dart';

class Group {
  final String id;
  final String name;
  final User owner;
  final List<User> members;
  final List<Bill> bills;
  final Map<String, double> balance;

//<editor-fold desc="Data Methods">
  const Group({
    this.id = '',
    required this.name,
    required this.owner,
    this.members = const [],
    this.bills = const [],
    this.balance = const {},
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Group &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          owner == other.owner &&
          members == other.members &&
          bills == other.bills &&
          balance == other.balance);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      owner.hashCode ^
      members.hashCode ^
      bills.hashCode ^
      balance.hashCode;

  @override
  String toString() {
    return 'Group{ id: $id, name: $name, owner: $owner, members: $members, bills: $bills, balance: $balance,}';
  }

  Group copyWith({
    String? id,
    String? name,
    User? owner,
    List<User>? members,
    List<Bill>? bills,
    Map<String, double>? balance,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      owner: owner ?? this.owner,
      members: members ?? this.members,
      bills: bills ?? this.bills,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ownerID': owner.id,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'] as String,
      name: map['name'] as String,
      owner: User.fromMap(map['owner'] as Map<String, dynamic>),
      members: (map['members'] as List<dynamic>)
          .map((member) => User.fromMap(member))
          .toList(),
      bills: (map['bills'] as List<dynamic>)
          .map((bill) => Bill.fromMap(bill))
          .toList(),
      balance: (map['balance'] as Map<String, dynamic>? ?? {})
          .map((key, value) => MapEntry(key, value.toDouble())),
    );
  }

//</editor-fold>
}
