// TODO: Use Freezed or json_serializable

import 'package:split_the_bill/domain/bill/bill.dart';

class Group {
  final String id;
  final String name;
  final double balance;
  final List<String> members;
  final List<Bill> bills;

//<editor-fold desc="Data Methods">
  const Group({
    required this.id,
    required this.name,
    required this.balance,
    required this.members,
    required this.bills,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Group &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          balance == other.balance &&
          members == other.members &&
          bills == other.bills);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      balance.hashCode ^
      members.hashCode ^
      bills.hashCode;

  @override
  String toString() {
    return 'Group{ id: $id, name: $name, balance: $balance, members: $members, bills: $bills,}';
  }

  Group copyWith({
    String? id,
    String? name,
    double? balance,
    List<String>? members,
    List<Bill>? bills,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      members: members ?? this.members,
      bills: bills ?? this.bills,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
      'members': members,
      'bills': bills,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'] as String,
      name: map['name'] as String,
      balance: map['balance'] as double,
      members: map['members'] as List<String>,
      bills: map['bills'] as List<Bill>,
    );
  }

//</editor-fold>
}
