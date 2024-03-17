import 'package:split_the_bill/auth/user.dart';

class Item {
  final String id;
  final String name;
  final double price;
  final String billId;
  final List<User> contributors;

  const Item(
      {required this.id,
      required this.name,
      required this.price,
      required this.billId,
      required this.contributors});

  factory Item.getDefault() {
    return const Item(
      id: '0',
      name: '',
      price: 0,
      billId: '',
      contributors: [],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          price == other.price &&
          billId == other.billId &&
          contributors == other.contributors;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      price.hashCode ^
      billId.hashCode ^
      contributors.hashCode;

  @override
  String toString() {
    return 'Item{id: $id, name: $name, price: $price, billId: $billId, contributors: $contributors}';
  }

  Item copyWith({
    String? id,
    String? name,
    double? price,
    String? billId,
    List<User>? contributors,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      billId: billId ?? this.billId,
      contributors: contributors ?? this.contributors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'contributors': contributors,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as String,
      name: map['name'] as String,
      price: (map['price'] is int)
          ? (map['price'] as int).toDouble()
          : map['price'] as double,
      billId: map['billId'] as String,
      contributors: (map['members'] as List<dynamic>?)
              ?.map((member) => User.fromMap(member))
              .toList() ??
          [],
    );
  }
}
