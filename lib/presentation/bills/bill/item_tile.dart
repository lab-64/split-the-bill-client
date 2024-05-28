import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/item.dart';
import 'package:split_the_bill/presentation/shared/extensions/currency_formatter.dart';
import 'package:split_the_bill/presentation/shared/components/fade_text.dart';
import 'package:split_the_bill/presentation/shared/profile/profile_image.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({super.key, required this.item, required this.balance});

  final Item item;
  final double balance;

  @override
  Widget build(BuildContext context) {
    Color color;
    if (balance > 0) {
      color = Colors.green;
    } else if (balance < 0) {
      color = Colors.red;
    } else {
      color = Colors.black;
    }
    return Column(
      children: [
        Card(
          elevation: 0,
          color: Colors.white,
          child: ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.inventory,
              color: Colors.blue,
            ),
            title: Row(
              children: [
                Expanded(
                  child: FadeText(
                    text: item.name,
                  ),
                ),
                gapW8,
                Row(
                  children: item.contributors.map((user) {
                    return Row(
                      children: [
                        ProfileImage(user: user, size: Sizes.p12),
                        gapW4,
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.price.toCurrencyString(),
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  balance.toCurrencyString(),
                  style: TextStyle(fontSize: 14, color: color),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
