import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';
import 'package:split_the_bill/presentation/groups/new_group/controllers.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';
import 'package:split_the_bill/presentation/shared/components/input_text_field.dart';

class NewGroupScreen extends StatefulWidget {
  const NewGroupScreen({super.key});

  @override
  State<NewGroupScreen> createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen> {
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _add(WidgetRef ref) {
    ref
        .read(newGroupControllerProvider.notifier)
        .addGroup(nameController.text)
        .then((_) => context.pop());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Group"),
      ),
      floatingActionButton: Consumer(builder: (context, ref, child) {
        ref.listen(newGroupControllerProvider,
            (_, next) => next.showSnackBarOnError(context));
        return ActionButton(
          icon: Icons.save,
          onPressed: () => _add(ref),
        );
      }),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InputTextField(
              labelText: 'Name*',
              prefixIcon: const Icon(Icons.description),
              controller: nameController,
            ),
            gapH48,
          ],
        ),
      ),
    );
  }
}
