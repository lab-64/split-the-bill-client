import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';
import 'package:split_the_bill/presentation/groups/new_group/controllers.dart';
import 'package:split_the_bill/presentation/shared/primary_button.dart';

class NewGroupScreen extends StatefulWidget {
  const NewGroupScreen({super.key});

  @override
  State<NewGroupScreen> createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen> {
  TextEditingController name = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Group"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p32),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: Colors.black),
              controller: name,
              decoration: const InputDecoration(
                labelText: "Name",
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
                      onPressed: () => ref
                          .read(newGroupControllerProvider.notifier)
                          .addGroup(name.text)
                          .then((_) => context.pop()),
                      text: 'Add',
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
