import 'item.dart';

class Bill {
  final String id;
  final String name;
  final String groupId;
  final String ownerId;
  final DateTime date;
  final List<Item> items;
  final Map<String, double> balance;

//<editor-fold desc="Data Methods">
  const Bill({
    required this.id,
    required this.name,
    required this.groupId,
    required this.ownerId,
    required this.date,
    required this.items,
    required this.balance,
  });

  factory Bill.getDefault() {
    return Bill(
      id: '0',
      name: '',
      groupId: '',
      ownerId: '',
      date: DateTime.now(),
      items: [
        Item.getDefault(),
      ],
      balance: {},
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bill &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          groupId == other.groupId &&
          ownerId == other.ownerId &&
          date == other.date &&
          items == other.items &&
          balance == other.balance;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      groupId.hashCode ^
      ownerId.hashCode ^
      date.hashCode ^
      items.hashCode ^
      balance.hashCode;

  @override
  String toString() {
    return 'Bill{id: $id, name: $name, groupId: $groupId, ownerId: $ownerId, date: $date, items: $items, balance: $balance}';
  }

  Bill copyWith({
    String? id,
    String? name,
    String? groupId,
    String? ownerId,
    DateTime? date,
    double? price,
    List<Item>? items,
    Map<String, double>? balance,
  }) {
    return Bill(
      id: id ?? this.id,
      name: name ?? this.name,
      groupId: groupId ?? this.groupId,
      ownerId: ownerId ?? this.ownerId,
      date: date ?? this.date,
      items: items ?? this.items,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'groupId': groupId,
      'ownerId': ownerId,
      // TODO: convert date
      //'date': date,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      id: map['id'] as String,
      name: map['name'] as String,
      groupId: map['groupID'] as String,
      ownerId: map['ownerID'] as String,
      date: DateTime.parse(map['date']),
      items: (map['items'] as List<dynamic>)
          .map((item) => Item.fromMap(item))
          .toList(),
      balance: (map['balance'] as Map<String, dynamic>? ?? {})
          .map((key, value) => MapEntry(key, value.toDouble())),
    );
  }
//</editor-fold>
}
