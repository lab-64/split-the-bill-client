import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/presentation/bills/new_bill/controllers.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';
import 'package:split_the_bill/presentation/shared/extensions/currency_formatter.dart';
import 'package:split_the_bill/presentation/shared/util/util.dart';

class RecognizedBillScreen extends ConsumerWidget {
  const RecognizedBillScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billRecognition = ref.watch(billRecognitionProvider);

    return Scaffold(
      floatingActionButton: ActionButton(
        icon: Icons.arrow_forward,
        onPressed: () => showNotImplementedSnackBar(context),
      ),
      appBar: AppBar(title: const Text("Recognized Bill")),
      body: AsyncValueWidget(
          value: billRecognition,
          data: (bill) {
            return ListView.builder(
              itemCount: bill.itemList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(bill.itemList[index]),
                  trailing: Text(bill.priceList[index].toCurrencyString()),
                );
              },
            );
          }),
    );
  }
}
