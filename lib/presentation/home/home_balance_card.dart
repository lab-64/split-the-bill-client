import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/app_sizes.dart';

class HomeBalanceCard extends StatelessWidget {
  const HomeBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(Sizes.p24),
      child: Container(
        decoration: _cardDecoration,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p24),
          child: _buildCardContent(),
        ),
      ),
    );
  }

  BorderRadius get _cardBorderRadius => BorderRadius.circular(Sizes.p24);

  BoxDecoration get _cardDecoration {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade300, Colors.blue.shade700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: _cardBorderRadius,
    );
  }

  Widget _buildCardContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCardText('My Balance', 14.0),
        _buildCardText('450.00 €', 36.0, fontWeight: FontWeight.w900),
      ],
    );
  }

  Widget _buildCardText(String text, double fontSize,
      {FontWeight? fontWeight}) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
