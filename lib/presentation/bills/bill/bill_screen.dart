import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/presentation/bills/bill/items_list.dart';
import 'package:split_the_bill/presentation/shared/components/snackbar.dart';
import 'package:split_the_bill/router/routes.dart';

import '../../../domain/bill/data/bill_repository.dart';

class BillScreen extends ConsumerWidget {
  const BillScreen({
    super.key,
    required this.billId,
  });

  final String billId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    final bill = ref.watch(billStateProvider(billId));

    return Scaffold(
      appBar: AppBar(
        title: Text(bill.value?.name ?? ""),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showNotImplementedSnackBar(context);
              /*
                context.goNamed(
                  Routes.editBill.name,
                  pathParameters: {
                    //'id': groupId,
                    'id': billId,
                  },
                );
                */
            },
          ),
          gapW8,
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                          "Are you sure, you want to delete this bill?"),
                      content: const Text(
                          "This will delete the bill for you and all group members!"),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              ref.read(billRepositoryProvider).delete(billId);
                              const HomeRoute().go(context);
                              Navigator.pop(context);
                            },
                            child: const Text("Yes")),
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("No")),
                      ],
                    )),
          ),
          gapW8,
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
