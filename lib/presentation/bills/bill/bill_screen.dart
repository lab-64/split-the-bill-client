import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/presentation/bills/bill/items_list.dart';
import 'package:split_the_bill/presentation/shared/util/util.dart';

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
          Padding(
            padding: const EdgeInsets.all(Sizes.p8),
            child: IconButton(
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
          ),
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
