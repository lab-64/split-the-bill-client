import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/app_sizes.dart';

class HomeBalanceCard extends StatelessWidget {
  const HomeBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(Sizes.p24),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade300, Colors.blue.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(Sizes.p24),
          ),
          child: const Padding(
            padding: EdgeInsets.all(Sizes.p24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'My Balance',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  '450.00 €',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
