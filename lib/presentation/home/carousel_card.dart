import 'package:flutter/material.dart';

import '../../domain/bill/bill.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({super.key, required this.bill});

  final Bill bill;

  @override
  Widget build(BuildContext context) {
    double price = bill.items.fold(0, (prev, item) => prev + item.price);
    return Column(
      children: [
        Text("Name: ${bill.name}"),
        Text("Price: $price"),
      ],
    );
  }
}
