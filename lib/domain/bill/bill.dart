import '../item/item.dart';

class Bill {
  final String id;
  final String name;
  final String groupId;
  final String ownerId;
  final DateTime date;
  final double price;
  final List<Item> items;

//<editor-fold desc="Data Methods">
  const Bill({
    required this.id,
    required this.name,
    required this.groupId,
    required this.ownerId,
    required this.date,
    required this.price,
    required this.items,
  });

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
          price == other.price &&
          items == other.items;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      groupId.hashCode ^
      ownerId.hashCode ^
      date.hashCode ^
      price.hashCode ^
      items.hashCode;

  @override
  String toString() {
    return 'Bill{id: $id, name: $name, groupId: $groupId, ownerId: $ownerId, date: $date, price: $price, items: $items}';
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
      price: price ?? this.price,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'groupId': groupId,
      'ownerId': ownerId,
      'date': date,
      'price': price,
      'items': items,
    };
  }

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      id: map['id'] as String,
      name: map['name'] as String,
      groupId: map['groupId'] as String,
      ownerId: map['ownerId'] as String,
      date: map['date'] as DateTime,
      price: map['price'] as double,
      items: map['items'] as List<Item>,
    );
  }
//</editor-fold>
}
