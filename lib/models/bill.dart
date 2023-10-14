import 'item.dart';

class Bill {
  late int id;
  late String name;
  late DateTime date;
  late List<Item> items;

  Bill(this.id, this.name, this.date, this.items);

  double getTotalPrice() {
    return items
        .map((e) => e.price)
        .reduce((value, element) => value + element);
  }
}
