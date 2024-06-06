class ItemContribution {
  final bool contributed;
  final String itemID;

//<editor-fold desc="Data Methods">
  const ItemContribution({
    required this.contributed,
    required this.itemID,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemContribution &&
          runtimeType == other.runtimeType &&
          contributed == other.contributed &&
          itemID == other.itemID);

  @override
  int get hashCode => contributed.hashCode ^ itemID.hashCode;

  @override
  String toString() {
    return 'ItemContribution{ contributed: $contributed, itemID: $itemID,}';
  }

  ItemContribution copyWith({
    bool? contributed,
    String? itemID,
  }) {
    return ItemContribution(
      contributed: contributed ?? this.contributed,
      itemID: itemID ?? this.itemID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contributed': this.contributed,
      'itemID': this.itemID,
    };
  }

//</editor-fold>
}
