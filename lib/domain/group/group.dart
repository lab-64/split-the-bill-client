// TODO: Use Freezed or json_serializable

import 'package:split_the_bill/domain/bill/bill.dart';

class Group {
  final String id;
  final String name;
  final String ownerID;
  final List<String> memberIDs;
  final List<Bill> bills;

//<editor-fold desc="Data Methods">
  const Group({
    required this.id,
    required this.name,
    required this.ownerID,
    required this.memberIDs,
    required this.bills,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Group &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          ownerID == other.ownerID &&
          memberIDs == other.memberIDs &&
          bills == other.bills);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      ownerID.hashCode ^
      memberIDs.hashCode ^
      bills.hashCode;

  @override
  String toString() {
    return 'Group{' +
        ' id: $id,' +
        ' name: $name,' +
        ' ownerID: $ownerID,' +
        ' members: $memberIDs,' +
        ' bills: $bills,' +
        '}';
  }

  Group copyWith({
    String? id,
    String? name,
    String? ownerID,
    double? balance,
    List<String>? memberIDs,
    List<Bill>? bills,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      ownerID: ownerID ?? this.ownerID,
      memberIDs: memberIDs ?? this.memberIDs,
      bills: bills ?? this.bills,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'ownerID': this.ownerID,
      'memberIDs': this.memberIDs,
      'bills': this.bills,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'] as String,
      name: map['name'] as String,
      ownerID: map['ownerID'] as String,
      memberIDs: (map['memberIDs'] as List<dynamic>)
          .map((member) => member as String)
          .toList(),
      bills: [],
/*      bills: (map['bills'] as List<dynamic>)
          .map((bill) => Bill.fromMap(bill))
          .toList()*/
    );
  }

//</editor-fold>
}
