import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/presentation/home/controllers.dart';
import 'package:split_the_bill/presentation/shared/extensions/currency_formatter.dart';

class HomeBalanceCard extends ConsumerWidget {
  const HomeBalanceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userTotalBalance = ref.watch(userTotalBalanceProvider);

    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(Sizes.p24),
      child: Container(
        decoration: _cardDecoration,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p24),
          child: _buildCardContent(userTotalBalance),
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

  Widget _buildCardContent(double userTotalBalance) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCardText(
          'My Balance',
          14.0,
          Colors.white,
        ),
        _buildCardText(
          userTotalBalance.toCurrencyString(),
          36.0,
          userTotalBalance >= 0 ? Colors.green.shade200 : Colors.pink.shade200,
          fontWeight: FontWeight.w900,
        ),
      ],
    );
  }

  Widget _buildCardText(String text, double fontSize, Color color,
      {FontWeight? fontWeight}) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
