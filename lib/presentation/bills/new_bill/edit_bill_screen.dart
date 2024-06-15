import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';
import 'package:split_the_bill/presentation/bills/new_bill/controllers.dart';
import 'package:split_the_bill/presentation/bills/new_bill/general_tab.dart';
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
  late XFile? image;
  int _currentIndex = 0;
  bool allSet = true;

  Future _getImage(ImageSource source) async {
    image = await _picker.pickImage(source: source);
    if (mounted) {
      ImageCropRoute(image!.path, widget.billId).push(context);
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

    //check if all users are set
    for (var item in bill.requireValue.items) {
      for (var user in group.requireValue.members) {
        if (!item.contributors.map((item) => item.id).contains(user.id)) {
          allSet = false;
          break;
        }
      }
    }

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
              isLoading: ref.watch(upsertBillControllerProvider).isLoading,
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
                  Tab(icon: Icon(Icons.description_outlined)),
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
                      setAll: setAll,
                      allSet: allSet,
                    ),
                    GeneralTab(
                      bill: bill,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void setAll(bool isSet) {
    final bill = ref.watch(editBillControllerProvider);
    final group = ref.watch(groupStateProvider(widget.groupId));
    setState(() {
      allSet = isSet;
      for (var item in bill.items) {
        if (isSet) {
          for (var user in group.requireValue.members) {
            if (!item.contributors.map((ele) => ele.id).contains(user.id)) {
              item.contributors.add(user);
            }
          }
        } else {
          item.contributors.removeRange(0, item.contributors.length);
        }
      }
    });
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
