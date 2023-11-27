class Bill {
  final String id;
  final String name;
  final String groupId;
  final String ownerId;
  final DateTime date;
  final List<String> contributors;
  final double price;

//<editor-fold desc="Data Methods">
  const Bill({
    required this.id,
    required this.name,
    required this.groupId,
    required this.ownerId,
    required this.date,
    required this.contributors,
    required this.price,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bill &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          groupId == other.groupId &&
          ownerId == other.ownerId &&
          date == other.date &&
          contributors == other.contributors &&
          price == other.price);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      groupId.hashCode ^
      ownerId.hashCode ^
      date.hashCode ^
      contributors.hashCode ^
      price.hashCode;

  @override
  String toString() {
    return 'Bill{ id: $id, name: $name, groupId: $groupId, ownerId: $ownerId, date: $date, contributors: $contributors, price: $price,}';
  }

  Bill copyWith({
    String? id,
    String? name,
    String? groupId,
    String? ownerId,
    DateTime? date,
    List<String>? contributors,
    double? price,
  }) {
    return Bill(
      id: id ?? this.id,
      name: name ?? this.name,
      groupId: groupId ?? this.groupId,
      ownerId: ownerId ?? this.ownerId,
      date: date ?? this.date,
      contributors: contributors ?? this.contributors,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'groupId': groupId,
      'ownerId': ownerId,
      'date': date,
      'contributors': contributors,
      'price': price,
    };
  }

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      id: map['id'] as String,
      name: map['name'] as String,
      groupId: map['groupId'] as String,
      ownerId: map['ownerId'] as String,
      date: map['date'] as DateTime,
      contributors: map['contributors'] as List<String>,
      price: map['price'] as double,
    );
  }

//</editor-fold>
}
