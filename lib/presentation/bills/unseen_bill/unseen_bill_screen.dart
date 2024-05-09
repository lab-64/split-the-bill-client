import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/presentation/bills/unseen_bill/bill_contribution.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/snackbar.dart';
import 'package:split_the_bill/router/routes.dart';

import '../../../auth/states/auth_state.dart';
import '../../../domain/bill/bill.dart';
import '../../../domain/bill/item.dart';
import '../../../domain/bill/states/bills_state.dart';

class UnseenBillScreen extends ConsumerStatefulWidget {
  const UnseenBillScreen({super.key, required this.billId});

  final String billId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UnseenBillScreenState();
}

class _UnseenBillScreenState extends ConsumerState<UnseenBillScreen> {
  Map<Item, bool> contributionMapping = {};

  @override
  Widget build(BuildContext context) {
    final bill = ref.watch(billStateProvider(widget.billId));

    return AsyncValueWidget(
      value: bill,
      data: (bill) => Scaffold(
        appBar: AppBar(
          title: const Text("Please select contribution"),
          actions: [
            IconButton(
                icon: const Icon(Icons.save),
                onPressed: () => _saveBill(ref, bill))
          ],
        ),
        body: BillContribution(
          bill: bill,
          changeContributionMapping: _changeContributionMapping,
        ),
      ),
    );
  }

  void _saveBill(WidgetRef ref, Bill bill) {
    final user = ref.watch(authStateProvider).requireValue;

    if (contributionMapping.length == bill.items.length) {
      for (var item in bill.items) {
        //not contributed, but part of contributors
        if (!contributionMapping[item]! && item.contributors.contains(user)) {
          item.contributors.remove(user);
          ref.read(billStateProvider(bill.id).notifier).editItem(item);
        }
        //contributed, but not part of contributors
        else {
          if (contributionMapping[item]! && !item.contributors.contains(user)) {
            item.contributors.add(user);
            ref.read(billStateProvider(bill.id).notifier).editItem(item);
          }
        }
      }
      ref.read(billsStateProvider().notifier).edit(bill, isViewed: true);
      const HomeRoute().go(context);
    } else {
      showErrorSnackBar(context, "Please view all items before saving!");
    }
  }

  void _changeContributionMapping(Map<Item, bool> contributionMapping) {
    setState(() {
      this.contributionMapping = contributionMapping;
    });
  }
}
