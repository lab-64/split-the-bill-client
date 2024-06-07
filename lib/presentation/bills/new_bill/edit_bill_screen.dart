import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';
import 'package:split_the_bill/presentation/bills/new_bill/controllers.dart';
import 'package:split_the_bill/presentation/bills/new_bill/edit_bill.dart';
import 'package:split_the_bill/presentation/bills/new_bill/items_check_dialog.dart';
import 'package:split_the_bill/presentation/bills/new_bill/scan_bill_modal.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/bottom_modal.dart';
import 'package:split_the_bill/presentation/shared/components/snackbar.dart';
import 'package:split_the_bill/router/routes.dart';

class EditBillScreen extends ConsumerStatefulWidget {
  const EditBillScreen({super.key, required this.groupId, this.billId = '0'});

  final String groupId;
  final String billId;

  @override
  ConsumerState<EditBillScreen> createState() => _NewBillScreenState();
}

class _NewBillScreenState extends ConsumerState<EditBillScreen> {
  final ImagePicker _picker = ImagePicker();
  late XFile? image;
  final LoadingButtonController _btnController = LoadingButtonController();

  Future _getImage(ImageSource source) async {
    image = await _picker.pickImage(source: source);
  }

  @override
  Widget build(BuildContext context) {
    final bill = ref.watch(billStateProvider(widget.billId));
    final group = ref.watch(groupStateProvider(widget.groupId));

    /// Show the items check dialog when the bill recognition starts
    ref.listen(
      billRecognitionProvider,
      (prev, next) => !prev!.isLoading
          ? showItemsCheckDialog(context, widget.billId)
          : null,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.billId == '0' ? "New Bill" : "Edit Bill"),
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
              ).whenComplete(() => ImageCropRoute(image!.path).push(context)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoadingButton(
              width: Sizes.p64 * 2,
              onPressed: () => _upsertBill(ref)
                  .then((_) => _onUpsertBillSuccess(ref, context)),
              controller: _btnController,
              child: const Row(
                children: [
                  Icon(
                    Icons.save,
                    color: Colors.blue,
                  ),
                  gapW8,
                  Text(
                    "Save",
                    style: TextStyle(fontSize: 18.0, color: Colors.blue),
                  )
                ],
              ),
            ),
          )
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

  Future<void> _upsertBill(WidgetRef ref) async {
    if (widget.billId == '0') {
      return ref
          .read(editBillControllerProvider.notifier)
          .addBill(widget.groupId);
    } else {
      return ref
          .read(editBillControllerProvider.notifier)
          .editBill(widget.billId);
    }
  }

  void _onUpsertBillSuccess(WidgetRef ref, BuildContext context) {
    final state = ref.watch(editBillControllerProvider);
    showSuccessSnackBar(
      context,
      state,
      widget.billId == '0' ? 'Bill created' : 'Bill updated',
      goTo: () => const HomeRoute().go(context),
    );
    //reset in case of error
    _btnController.reset();
  }
}
