import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';
import 'package:split_the_bill/presentation/groups/groups/controllers.dart';
import 'package:split_the_bill/presentation/shared/components/input_text_field.dart';
import 'package:split_the_bill/presentation/shared/components/snackbar.dart';

class JoinGroupDialog extends ConsumerStatefulWidget {
  const JoinGroupDialog({super.key});

  @override
  ConsumerState<JoinGroupDialog> createState() => _JoinGroupDialogState();
}

class _JoinGroupDialogState extends ConsumerState<JoinGroupDialog> {
  late TextEditingController _controller;
  bool _canJoin = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _joinGroup() async {
    await ref
        .read(invitationControllerProvider.notifier)
        .acceptInvitation(_controller.text);
  }

  void _onSuccess() {
    final state = ref.watch(invitationControllerProvider);
    Navigator.of(context).pop();

    showSuccessSnackBar(
      context,
      state,
      'You joined a new group!',
    );
  }

  bool _isUUID(String input) {
    final uuid = RegExp(
        r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$');
    return uuid.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      invitationControllerProvider,
      (_, next) => next.showSnackBarOnError(context),
    );

    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return AlertDialog(
          title: const Center(
            child: Text("Join Group"),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Type in Invitation ID to join"),
              gapH24,
              InputTextField(
                labelText: "Invitation ID",
                prefixIcon: const Icon(Icons.numbers),
                controller: _controller,
                onChanged: (_) => setState(() {
                  _canJoin = _isUUID(_controller.text);
                }),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
            TextButton(
              onPressed: _canJoin
                  ? () => _joinGroup().then((_) => _onSuccess())
                  : null,
              child: const Text("Join"),
            ),
          ],
        );
      },
    );
  }
}
