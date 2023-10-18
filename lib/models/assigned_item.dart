import 'package:split_the_bill/models/item.dart';
import 'package:split_the_bill/models/user.dart';

class AssignedItem extends Item {
  AssignedItem(super.id, super.name, super.price, this.assignedTo);

  late User assignedTo;

  //TODO maybe delete
  Item convertToItem() {
    return Item(id, name, price);
  }
}
