import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation/shared/extensions/currency_formatter.dart';

import '../../../constants/ui_constants.dart';
import '../../../domain/bill/item.dart';
import '../../shared/components/fade_text.dart';
import 'item_member_list.dart';

class ItemExpandedTile extends StatelessWidget {
  const ItemExpandedTile({
    super.key,
    required this.item,
    required this.getBalance,
  });

  final Item item;
  final Function getBalance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Sizes.p8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.inventory,
                    color: Colors.blue,
                  ),
                  gapW8,
                  FadeText(
                    text: "Name: ${item.name}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.euro,
                    color: Colors.blue,
                  ),
                  gapW8,
                  FadeText(
                    text: "Total price: ${item.price.toCurrencyString()}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.euro,
                    color: Colors.blue,
                  ),
                  gapW8,
                  FadeText(
                    text: _getPersonalPrice(getBalance()),
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              if (item.contributors.isNotEmpty) ...[
                const Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: Colors.blue,
                    ),
                    gapW8,
                    Text("Contributors:", style: TextStyle(fontSize: 18)),
                  ],
                ),
                gapH8,
                ItemMemberList(members: item.contributors)
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _getPersonalPrice(double price) {
    if (price > 0) {
      return "Price you receive: ${price.toCurrencyString()}";
    } else if (price < 0) {
      return "Price to pay: ${price.abs().toCurrencyString()}";
    } else {
      return "No money transaction necessary";
    }
  }
}
