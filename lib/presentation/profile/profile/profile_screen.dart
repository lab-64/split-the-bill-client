import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';
import 'package:split_the_bill/presentation/shared/components/input_text_field.dart';
import 'package:split_the_bill/presentation/shared/profile/profile_image.dart';
import 'package:split_the_bill/router/routes.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  Future<void> _logout(WidgetRef ref) async {
    final controller = ref.read(authStateProvider.notifier);
    await controller.logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).requireValue;
    final email = TextEditingController(text: user.email);
    final username = TextEditingController(text: user.username);

    ref.listen(
      authStateProvider,
      (_, next) => next.showSnackBarOnError(context),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => const EditProfileRoute().go(context),
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => _logout(ref),
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p24),
        child: Column(
          children: [
            ProfileImage(
              user: user,
              size: Sizes.p64,
            ),
            gapH24,
            InputTextField(
              labelText: "Email",
              prefixIcon: const Icon(Icons.email),
              controller: email,
              isDisabled: true,
            ),
            gapH16,
            InputTextField(
              labelText: "Username",
              prefixIcon: const Icon(Icons.person),
              controller: username,
              isDisabled: true,
            ),
          ],
        ),
      ),
    );
  }
}
