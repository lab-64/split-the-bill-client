import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';
import 'package:split_the_bill/presentation/groups/new_group/controllers.dart';
import 'package:split_the_bill/presentation/shared/components/primary_button.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              style: const TextStyle(color: Colors.black),
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Sizes.p24),
                ),
                labelText: "Name",
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.drive_file_rename_outline),
              ),
            ),
            gapH48,
            Consumer(builder: (context, ref, child) {
              ref.listen(newGroupControllerProvider,
                  (_, next) => next.showSnackBarOnError(context));

              return Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      isLoading:
                          ref.watch(newGroupControllerProvider).isLoading,
                      onPressed: () => _add(ref),
                      icon: Icons.add,
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
