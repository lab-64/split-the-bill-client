import 'package:flutter/material.dart';

import '../../../constants/app_sizes.dart';
import '../../../domain/item/item.dart';

class ItemListTile extends StatelessWidget {
  const ItemListTile({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      margin:
          const EdgeInsets.symmetric(vertical: Sizes.p8, horizontal: Sizes.p16),
      elevation: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.p24),
      ),
      shadowColor: Colors.blue,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.p24),
        ),
        textColor: Colors.white,
        leading: const Icon(
          Icons.attach_money,
          color: Colors.lightGreenAccent,
        ),
        title: Text(
          item.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text('${item.price} €'),
        trailing: const Icon(
          Icons.navigate_next,
          color: Colors.white,
        ),
        onTap: () {},
      ),
    );
  }
}
