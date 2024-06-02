import 'package:split_the_bill/auth/user.dart';

import 'item.dart';

class Bill {
  final String id;
  final String name;
  final String groupId;
  final User owner;
  final DateTime date;
  final List<Item> items;
  final Map<String, double> balance;
  final bool isViewed;
  final DateTime updatedAt;

//<editor-fold desc="Data Methods">
  const Bill(
      {required this.id,
      required this.name,
      required this.groupId,
      required this.owner,
      required this.date,
      required this.items,
      required this.balance,
      required this.isViewed,
      required this.updatedAt});

  factory Bill.getDefault() {
    return Bill(
        id: '0',
        name: '',
        groupId: '',
        owner: User.getDefault(),
        date: DateTime.now(),
        items: [
          Item.getDefault(),
        ],
        balance: {},
        isViewed: true,
        updatedAt: DateTime.now());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bill &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          groupId == other.groupId &&
          owner == other.owner &&
          date == other.date &&
          items == other.items &&
          balance == other.balance &&
          isViewed == other.isViewed &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      groupId.hashCode ^
      owner.hashCode ^
      date.hashCode ^
      items.hashCode ^
      balance.hashCode ^
      isViewed.hashCode ^
      updatedAt.hashCode;

  @override
  String toString() {
    return 'Bill{id: $id, name: $name, groupId: $groupId, owner: $owner, date: $date, items: $items, balance: $balance, isViewed: $isViewed, updatedAt: $updatedAt}';
  }

  Bill copyWith({
    String? id,
    String? name,
    String? groupId,
    User? owner,
    DateTime? date,
    double? price,
    List<Item>? items,
    Map<String, double>? balance,
    bool? isViewed,
    DateTime? updatedAt
  }) {
    return Bill(
      id: id ?? this.id,
      name: name ?? this.name,
      groupId: groupId ?? this.groupId,
      owner: owner ?? this.owner,
      date: date ?? this.date,
      items: items ?? this.items,
      balance: balance ?? this.balance,
      isViewed: isViewed ?? this.isViewed,
      updatedAt: updatedAt ?? this.updatedAt
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'groupId': groupId,
      'ownerID': owner.id,
      'date': '${date.toIso8601String().split('.')[0]}Z',
      'items': items.map((item) => item.toMap()).toList(),
      'isViewed': isViewed,
      'updatedAt': '${updatedAt.toIso8601String().split('.')[0]}Z'
    };
  }

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      id: map['id'] as String,
      name: map['name'] as String,
      groupId: map['groupID'] as String,
      owner: User.fromMap(map['owner'] as Map<String, dynamic>),
      date: DateTime.parse(map['date']),
      items: (map['items'] as List<dynamic>)
          .map((item) => Item.fromMap(item))
          .toList(),
      balance: (map['balance'] as Map<String, dynamic>? ?? {})
          .map((key, value) => MapEntry(key, value.toDouble())),
      isViewed: map['isViewed'] as bool? ?? true,
      updatedAt: DateTime.parse(map['updatedAt'])
    );
  }
//</editor-fold>
}
