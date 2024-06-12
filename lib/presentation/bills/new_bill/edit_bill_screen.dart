import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';
import 'package:split_the_bill/presentation/bills/new_bill/controllers.dart';
import 'package:split_the_bill/presentation/bills/new_bill/general_tab.dart';
import 'package:split_the_bill/presentation/bills/new_bill/items_check_dialog.dart';
import 'package:split_the_bill/presentation/bills/new_bill/items_tab.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';
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
  int _currentIndex = 0;

  Future _getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      await ref
          .read(billRecognitionProvider.notifier)
          .runBillRecognition(image);
    }
  }

  void _updateCurrentIndex(BuildContext context) {
    void handleTabChange() {
      setState(() {
        _currentIndex = DefaultTabController.of(context).index;
      });
    }

    DefaultTabController.of(context).addListener(handleTabChange);
  }

  @override
  void initState() {
    super.initState();
    if (widget.billId != '0') {
      Future.delayed(
        Duration.zero,
        () => ref
            .read(editBillControllerProvider.notifier)
            .setBill(widget.billId),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bill = AsyncData(ref.watch(editBillControllerProvider));
    final group = ref.watch(groupStateProvider(widget.groupId));
    final user = ref.watch(authStateProvider);

    /// Show the items check dialog when the bill recognition starts
    ref.listen(
      billRecognitionProvider,
      (prev, next) => !prev!.isLoading
          ? showItemsCheckDialog(context, widget.billId)
          : null,
    );

    ref.listen(
      upsertBillControllerProvider,
      (_, next) => next.showSnackBarOnError(context),
    );

    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          _updateCurrentIndex(context);

          return Scaffold(
            floatingActionButton: ActionButton(
              icon: _currentIndex == 1 ? Icons.save : Icons.arrow_forward,
              onPressed: () {
                if (_currentIndex == 1) {
                  _upsertBill(ref)
                      .then((_) => _onUpsertBillSuccess(ref, context));
                } else {
                  DefaultTabController.of(context).animateTo(
                    DefaultTabController.of(context).index + 1,
                  );
                }
              },
            ),
            appBar: AppBar(
              title: Text(widget.billId == '0' ? "New Bill" : "Edit Bill"),
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.list)),
                  Tab(icon: Icon(Icons.settings)),
                ],
              ),
            ),
            body: AsyncValueWidget(
              value: group,
              data: (group) => AsyncValueWidget(
                value: bill,
                data: (bill) => TabBarView(
                  children: [
                    ItemsTab(
                      getImage: _getImage,
                      group: group,
                      bill: bill,
                      userId: user.requireValue.id,
                    ),
                    GeneralTab(bill: bill),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _upsertBill(WidgetRef ref) async {
    if (widget.billId == '0') {
      return ref
          .read(upsertBillControllerProvider.notifier)
          .addBill(widget.groupId);
    } else {
      return ref
          .read(upsertBillControllerProvider.notifier)
          .editBill(widget.billId);
    }
  }

  void _onUpsertBillSuccess(WidgetRef ref, BuildContext context) {
    final state = ref.watch(upsertBillControllerProvider);
    showSuccessSnackBar(
      context,
      state,
      widget.billId == '0' ? 'Bill created' : 'Bill updated',
      goTo: () => const HomeRoute().go(context),
    );
  }
}
