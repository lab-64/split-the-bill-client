import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation/home/carousel_card.dart';

import '../../domain/bill/bill.dart';
import '../../domain/group/group.dart';

class HomeBillCarousel extends StatefulWidget {
  const HomeBillCarousel(
      {super.key, required this.bills, required this.groups});

  final List<Bill> bills;
  final List<Group> groups;

  @override
  State<HomeBillCarousel> createState() => _HomeBillCarouselState();
}

class _HomeBillCarouselState extends State<HomeBillCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final billCards = List.generate(
      widget.bills.length,
      (index) => CarouselCard(
        bill: widget.bills[index],
        groupName: widget.groups
            .firstWhere((group) => group.id == widget.bills[index].groupId)
            .name,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider.builder(
          itemCount: billCards.length,
          itemBuilder: (BuildContext context, int index, int realIdx) {
            return billCards[index];
          },
          options: CarouselOptions(
            autoPlay: true,
            enableInfiniteScroll: false,
            height: 230,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: billCards.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => setState(() => _currentIndex = entry.key),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
