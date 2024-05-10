import 'package:flutter/material.dart';

import '../../../constants/app_sizes.dart';
import '../../../domain/bill/item.dart';
import '../../shared/profile/profile_image.dart';

class ItemContribution extends StatelessWidget {
  const ItemContribution({
    super.key,
    required this.updateContribution,
    required this.item,
    required this.index,
  });

  final Function updateContribution;
  final Item item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p24),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.inventory,
                color: Colors.blue,
              ),
              gapW32,
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Name: "),
                      gapW16,
                      Text(item.name),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Price: "),
                      gapW16,
                      Text("${item.price}€"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Contributors:"),
                      gapW8,
                      Row(
                        children: item.contributors.map(
                          (user) {
                            return Row(
                              children: [
                                ProfileImage(user: user, size: Sizes.p12),
                                gapW4,
                              ],
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          gapH8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => updateContribution(true, index),
                icon: const Icon(Icons.check, color: Colors.green),
              ),
              IconButton(
                onPressed: () => updateContribution(false, index),
                icon: const Icon(Icons.close, color: Colors.red),
              ),
            ],
          )
        ],
      ),
    );
  }
}
