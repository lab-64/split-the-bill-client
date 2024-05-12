import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:split_the_bill/constants/app_sizes.dart';

class DateLabel extends StatelessWidget {
  final DateTime date;

  const DateLabel({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Sizes.p4),
      child: Text(
        DateFormat('dd. MMMM').format(date),
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}
