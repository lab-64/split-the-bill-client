import '../item/item.dart';

class Bill {
  final String id;
  final String name;
  final String groupId;
  final String ownerId;
  final DateTime date;
  final List<Item> items;

//<editor-fold desc="Data Methods">
  const Bill({
    required this.id,
    required this.name,
    required this.groupId,
    required this.ownerId,
    required this.date,
    required this.items,
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
          items == other.items;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      groupId.hashCode ^
      ownerId.hashCode ^
      date.hashCode ^
      items.hashCode;

  @override
  String toString() {
    return 'Bill{id: $id, name: $name, groupId: $groupId, ownerId: $ownerId, date: $date, items: $items}';
  }

  Bill copyWith({
    String? id,
    String? name,
    String? groupId,
    String? ownerId,
    DateTime? date,
    double? price,
    List<Item>? items,
  }) {
    return Bill(
      id: id ?? this.id,
      name: name ?? this.name,
      groupId: groupId ?? this.groupId,
      ownerId: ownerId ?? this.ownerId,
      date: date ?? this.date,
      items: items ?? this.items,
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
      date: DateTime.now(),
      // TODO: get and convert date
      // date: map['date'] as DateTime,
      items: (map['items'] as List<dynamic>)
          .map((item) => Item.fromMap(item))
          .toList(),
    );
  }
//</editor-fold>
}
