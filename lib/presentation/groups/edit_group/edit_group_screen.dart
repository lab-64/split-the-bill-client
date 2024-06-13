import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/domain/group/states/group_state.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';
import 'package:split_the_bill/presentation/groups/edit_group/controllers.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';
import 'package:split_the_bill/presentation/shared/components/input_text_form_field.dart';
import 'package:split_the_bill/presentation/shared/components/snackbar.dart';

class EditGroupScreen extends ConsumerStatefulWidget {
  const EditGroupScreen({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  ConsumerState<EditGroupScreen> createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends ConsumerState<EditGroupScreen> {
  TextEditingController nameController = TextEditingController();
  final _editGroupFormKey = GlobalKey<FormState>();
  bool _isNew = false;

  late Group _group;

  @override
  void initState() {
    super.initState();
    _isNew = widget.groupId == '0';
    if (!_isNew) {
      _group = ref.read(groupStateProvider(widget.groupId)).requireValue;
    }
    nameController.text = _isNew ? '' : _group.name;
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> _add() async {
    await ref
        .read(editGroupControllerProvider.notifier)
        .addGroup(nameController.text);
  }

  Future<void> _edit() async {
    Group group = _group.copyWith(name: nameController.text);
    await ref.read(editGroupControllerProvider.notifier).editGroup(group);
  }

  void _onSuccess() {
    final state = ref.watch(editGroupControllerProvider);
    showSuccessSnackBar(
      context,
      state,
      _isNew ? 'Group created' : 'Group updated',
    );
  }

  String? _validateGroupName(String? value) {
    if (value!.isEmpty) {
      return "Please enter a group name";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      editGroupControllerProvider,
      (_, next) => next.showSnackBarOnError(context),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? "New Group" : "Edit Group"),
      ),
      floatingActionButton: ActionButton(
        icon: Icons.save,
        isLoading: ref.watch(editGroupControllerProvider).isLoading,
        onPressed: () {
          if (_editGroupFormKey.currentState!.validate()) {
            (_isNew ? _add() : _edit()).then((_) => _onSuccess());
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
                key: _editGroupFormKey,
                child: InputTextFormField(
                  autofocus: true,
                  labelText: 'Name*',
                  prefixIcon: const Icon(Icons.description),
                  controller: nameController,
                  validator: (value) => _validateGroupName(value),
                )),
            gapH48,
          ],
        ),
      ),
    );
  }
}
