// TODO: Use Freezed or json_serializable

import 'package:flutter/cupertino.dart';
import 'package:split_the_bill/domain/bill/bill.dart';

class Group {
  final String id;
  final String name;
  final String owner;
  final double balance;
  final List<String> members;
  final List<Bill> bills;

//<editor-fold desc="Data Methods">
  const Group({
    required this.id,
    required this.name,
    required this.owner,
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
          owner == other.owner &&
          balance == other.balance &&
          members == other.members &&
          bills == other.bills);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      owner.hashCode ^
      balance.hashCode ^
      members.hashCode ^
      bills.hashCode;

  @override
  String toString() {
    return 'Group{' +
        ' id: $id,' +
        ' name: $name,' +
        ' owner: $owner,' +
        ' balance: $balance,' +
        ' members: $members,' +
        ' bills: $bills,' +
        '}';
  }

  Group copyWith({
    String? id,
    String? name,
    String? owner,
    double? balance,
    List<String>? members,
    List<Bill>? bills,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      owner: owner ?? this.owner,
      balance: balance ?? this.balance,
      members: members ?? this.members,
      bills: bills ?? this.bills,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'owner': this.owner,
      'balance': this.balance,
      'members': this.members,
      'bills': this.bills,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    debugPrint(map.toString());
    return Group(
      id: map['id'] as String,
      name: map['name'] as String,
      owner: map['owner'] as String,
      balance: map['balance'] ?? 0.00,
      members: (map['members'] as List<dynamic>)
          .map((member) => member as String)
          .toList(),
      bills: (map['bills'] as List<dynamic>)
          .map((bill) => Bill.fromMap(bill))
          .toList(),
    );
  }

//</editor-fold>
}