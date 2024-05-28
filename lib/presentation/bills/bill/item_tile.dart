import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/item.dart';
import 'package:split_the_bill/presentation/shared/components/fade_text.dart';
import 'package:split_the_bill/presentation/shared/profile/profile_image.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
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
