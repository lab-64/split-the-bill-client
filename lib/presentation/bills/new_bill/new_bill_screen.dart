import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';
import 'package:split_the_bill/presentation/bills/new_bill/controllers.dart';
import 'package:split_the_bill/presentation/bills/new_bill/edit_bill.dart';
import 'package:split_the_bill/presentation/bills/new_bill/items_check_dialog.dart';
import 'package:split_the_bill/presentation/bills/new_bill/scan_bill_modal.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';
import 'package:split_the_bill/presentation/shared/components/snackbar.dart';
import 'package:split_the_bill/presentation/shared/components/bottom_modal.dart';
import 'package:split_the_bill/presentation/shared/components/custom_dialog.dart';
import 'package:split_the_bill/router/routes.dart';

class NewBillScreen extends ConsumerStatefulWidget {
  const NewBillScreen({super.key, required this.groupId, this.billId = '0'});
  final String groupId;
  final String billId;

  @override
  ConsumerState<NewBillScreen> createState() => _NewBillScreenState();
}

class _NewBillScreenState extends ConsumerState<NewBillScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future _getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    setState(() {
      if (image != null) {
        _image = image;
        ref.watch(billRecognitionProvider.notifier).runBillRecognition(_image);
        Navigator.of(context).pop();

        showCustomDialog(
          context: context,
          content: const ItemsCheckDialog(),
          title: 'Check Items',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bill = ref.watch(billStateProvider(widget.billId));
    final group = ref.watch(groupStateProvider(widget.groupId));

    return Scaffold(
      floatingActionButton: ActionButton(
        icon: Icons.save,
        onPressed: () => _addBill(ref).then(
          (_) => _onAddBillSuccess(ref, context),
        ),
      ),
      appBar: AppBar(
        title: const Text("New Bill"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: Sizes.p8),
            child: IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () => showBottomModal(
                context,
                "Scan Bill",
                ScanBillModal(
                  getImage: _getImage,
                ),
              ),
            ),
          ),
        ],
      ),
      body: AsyncValueWidget(
        value: group,
        data: (group) => AsyncValueWidget(
          value: bill,
          data: (bill) => EditBill(
            bill: bill,
            group: group,
          ),
        ),
      ),
    );
  }

  Future<void> _addBill(WidgetRef ref) async {
    return ref
        .read(editBillControllerProvider.notifier)
        .addBill(widget.groupId);
  }

  void _onAddBillSuccess(WidgetRef ref, BuildContext context) {
    final state = ref.watch(editBillControllerProvider);
    showSuccessSnackBar(
      context,
      state,
      'Bill created',
      goTo: () => const HomeRoute().go(context),
    );
  }
}
