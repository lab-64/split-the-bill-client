import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';
import 'package:split_the_bill/presentation/bills/bill/items_list.dart';
import 'package:split_the_bill/presentation/shared/components/snackbar.dart';

import '../../../router/routes.dart';

class BillScreen extends ConsumerWidget {
  const BillScreen({
    super.key,
    required this.billId,
  });

  final String billId;

  void _deleteBill(WidgetRef ref) async {
    final bill = await ref.watch(billStateProvider(billId).future);
    ref.read(billsStateProvider.notifier).delete(bill);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    final bill = ref.watch(billStateProvider(billId));

    return Scaffold(
      appBar: AppBar(
        title: Text(bill.value?.name ?? ""),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                  onTap: () {
                    showNotImplementedSnackBar(context);
                    /*context.goNamed(
                            Routes.editBill.name,
                            pathParameters: {
                              //'id': groupId,
                              'id': billId,
                            },
                          );*/
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.blueAccent,
                      ),
                      gapW16,
                      Text("Edit")
                    ],
                  )),
              PopupMenuItem(
                child: const Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    gapW16,
                    Text("Delete"),
                  ],
                ),
                onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text(
                              "Are you sure, you want to delete this bill?"),
                          content: const Text(
                              "This will delete the bill for you and all group members!"),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  _deleteBill(ref);
                                  const HomeRoute().go(context);
                                  Navigator.pop(context);
                                },
                                child: const Text("Yes")),
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("No"))
                          ],
                        )),
              ),
            ],
            position: PopupMenuPosition.under,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
        child: CustomScrollView(
          slivers: [
            ItemsList(
              scrollController: scrollController,
              bill: bill,
            ),
          ],
        ),
      ),
    );
  }
}
