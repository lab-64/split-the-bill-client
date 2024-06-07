import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:split_the_bill/presentation/home/carousel_card.dart';

import '../../domain/bill/bill.dart';
import '../shared/components/headline.dart';

class HomeBillCarousel extends StatefulWidget {
  const HomeBillCarousel({super.key, required this.bills});

  final List<Bill> bills;

  @override
  State<HomeBillCarousel> createState() => _HomeBillCarouselState();
}

class _HomeBillCarouselState extends State<HomeBillCarousel> {
  @override
  Widget build(BuildContext context) {
    final billCards = List.generate(
      widget.bills.length,
      (index) => CarouselCard(
        bill: widget.bills[index],
      ),
    );

    return Column(children: [
      const Headline(title: "Recent Bills"),
      Swiper(itemCount: billCards.length),
    ]);
  }
}
