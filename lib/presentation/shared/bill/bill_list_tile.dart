import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/bill.dart';

class BillListTile extends StatelessWidget {
  const BillListTile({super.key, required this.bill});
  final Bill bill;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      margin:
          const EdgeInsets.symmetric(vertical: Sizes.p8, horizontal: Sizes.p16),
      elevation: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.p24),
      ),
      shadowColor: Colors.blue,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.p24),
        ),
        textColor: Colors.white,
        leading: const Icon(
          Icons.attach_money,
          color: Colors.lightGreenAccent,
        ),
        title: Text(
          bill.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text('${bill.price} €'),
        trailing: const Icon(
          Icons.navigate_next,
          color: Colors.white,
        ),
        onTap: () {},
      ),
    );
  }
}
