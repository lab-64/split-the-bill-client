import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/item.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({super.key, required this.item});

  final Item item;
  final String balance = "You Own: 50.00 €";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 0,
          child: ListTile(
            onTap: () {},
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
                    return const Row(
                      children: [
                        CircleAvatar(
                          radius: Sizes.p8,
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
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
