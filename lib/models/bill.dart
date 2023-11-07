import 'item.dart';

class Bill {
  late int id;
  late String name;
  late DateTime date;
  late List<Item> items;
  late int price;

  Bill(this.id, this.name, this.date, this.items, this.price);
}
