class BillSuggestion {
  final List<String> nameList;
  final List<double> priceList;

  const BillSuggestion({
    required this.nameList,
    required this.priceList,
  });

  BillSuggestion copyWith({
    List<String>? nameList,
    List<double>? priceList,
  }) {
    return BillSuggestion(
      nameList: nameList ?? this.nameList,
      priceList: priceList ?? this.priceList,
    );
  }
}
