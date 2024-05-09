import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/profile/profile_image.dart';
import 'package:split_the_bill/router/routes.dart';

class NotificationsDialog extends ConsumerWidget {
  const NotificationsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              "Tap on the bill to set your contribution",
              style: TextStyle(),
            ),
            const Divider(),
            Column(
              children: List.generate(
                bills.length,
                (index) => ListTile(
                  leading: ProfileImage(
                    user: bills[index].owner,
                    size: Sizes.p16,
                  ),
                  title: Text(bills[index].name),
                  subtitle: const Text("New bill"),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.of(context).pop();
                    UnseenBillRoute(billId: bills[index].id).push(context);
                  },
                ),
              ).toList(),
            ),
          ],
        );
      },
    );
  }
}
