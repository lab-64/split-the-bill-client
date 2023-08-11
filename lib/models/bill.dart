import 'item.dart';

class Bill {
  late int id;
  late DateTime date;
  late List<Item> items;

  Bill(this.id, this.date, this.items);
}
