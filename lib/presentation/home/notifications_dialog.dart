import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/date_label.dart';
import 'package:split_the_bill/presentation/shared/profile/profile_image.dart';
import 'package:split_the_bill/router/routes.dart';

import '../../auth/states/auth_state.dart';
import '../../domain/bill/bill.dart';
import '../bills/unseen_bill/controllers.dart';

class NotificationsDialog extends ConsumerStatefulWidget {
  const NotificationsDialog({super.key});

  @override
  ConsumerState<NotificationsDialog> createState() =>
      _NotificationsDialogState();
}

class _NotificationsDialogState extends ConsumerState<NotificationsDialog> {
  List<Bill> localBills = [];
  List<Bill> bills = [];

  @override
  void initState() {
    bills = ref.read(billsStateProvider(isUnseen: true)).requireValue;
    localBills = List.from(bills);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bills = ref.watch(billsStateProvider(isUnseen: true));

    return AsyncValueWidget(
      value: bills,
      data: (bills) {
        if (bills.isEmpty) {
          return const Center(
            child: Text("Nothing new here :)"),
          );
        }
        return Column(
          children: [
            const Text(
              "Tap to confirm your contributions",
              style: TextStyle(),
            ),
            const Divider(),
            Column(
              children: List.generate(
                localBills.length,
                (index) => Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) async {
                    setState(() {
                      localBills.removeAt(index);
                    });
                    if (direction == DismissDirection.startToEnd) {
                      await _populateContributions(bills[index]);
                    } else {
                      await _depopulateContributions(bills[index]);
                    }
                  },
                  background: Container(
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: ListTile(
                    leading: ProfileImage(
                      user: localBills[index].owner,
                      size: Sizes.p16,
                    ),
                    title: Text(localBills[index].name),
                    subtitle: DateLabel(date: localBills[index].date),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.of(context).pop();
                      UnseenBillRoute(billId: localBills[index].id)
                          .push(context);
                    },
                  ),
                ),
              ).toList(),
            ),
          ],
        );
      },
    );
  }

  Future<void> _depopulateContributions(Bill bill) async {
    final items = ref.watch(itemsContributionsProvider(bill));
    final user = ref.watch(authStateProvider).requireValue;
    for (var item in items) {
      item.contributors.removeWhere((userElement) => userElement.id == user.id);
    }
    await ref.read(billsStateProvider().notifier).edit(bill);
    ref.invalidate(billsStateProvider(isUnseen: true));
  }

  Future<void> _populateContributions(Bill bill) async {
    final items = ref.watch(itemsContributionsProvider(bill));
    final user = ref.watch(authStateProvider).requireValue;
    for (var item in items) {
      item.contributors.add(user);
    }
    await ref.read(billsStateProvider().notifier).edit(bill);
    ref.invalidate(billsStateProvider(isUnseen: true));
  }
}
