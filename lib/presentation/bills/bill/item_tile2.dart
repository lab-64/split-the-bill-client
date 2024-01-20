import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/item/item.dart';

class ItemTile2 extends StatelessWidget {
  const ItemTile2({super.key, required this.item});

  final Item item;

  // Replace this with the actual balance calculation logic
  final String balance = "You Own: 50.00 €";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 0,
          child: ListTile(
            onTap: () {
              // Add your onTap logic here
            },
            dense: true,
            leading: const Icon(
              Icons.inventory,
              color: Colors.blue,
            ),
            title: Row(
              children: [
                Text(
                  item.name,
                ),
                gapW8,
                Row(
                  children: item.contributors.map((user) {
                    return Row(
                      children: [
                        const CircleAvatar(
                          radius: 8.0,
                          backgroundImage: AssetImage('assets/avatar.jpg'),
                        ),
                        gapW4,
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
            trailing: Text(
              '${item.price} €',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
