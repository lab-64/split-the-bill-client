import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/presentation/profile/edit_profile/controllers.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';
import 'package:split_the_bill/presentation/shared/components/input_text_field.dart';
import 'package:split_the_bill/presentation/shared/components/snackbar.dart';
import 'package:split_the_bill/presentation/shared/profile/profile_image.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  late User user;

  @override
  void initState() {
    user = ref.read(authStateProvider).requireValue;
    username.text = user.username;
    email.text = user.email;
    super.initState();
  }

  @override
  void dispose() {
    username.dispose();
    super.dispose();
  }

  Future<void> _update() async {
    return await ref
        .read(editProfileControllerProvider.notifier)
        .updateUser(username.text);
  }

  void _onUpdateSuccess() {
    final state = ref.watch(authStateProvider);
    showSuccessSnackBar(context, state, 'Profile updated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      floatingActionButton: ActionButton(
        icon: Icons.save,
        onPressed: () => _update().then(
          (_) => _onUpdateSuccess(),
        ),
      ),
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
            ),
          ],
        ),
      ),
    );
  }
}
