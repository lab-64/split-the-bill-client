import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/date_label.dart';
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
              "Tap to confirm your contributions",
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
                  subtitle: DateLabel(date: bills[index].date),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.of(context).pop();
                    EditContributionsRoute(billId: bills[index].id).push(context);
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
