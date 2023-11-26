import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/presentation/shared/primary_button.dart';
import 'package:split_the_bill/utils/async_value_ui.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final controller = ref.read(authStateProvider.notifier);

    await controller.login(
      email: email.text,
      password: password.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
        authStateProvider, (_, next) => next.showAlertDialogOnError(context));

    final state = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign In',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p32),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: Colors.black),
              controller: email,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: const Icon(Icons.email),
                enabled: !state.isLoading,
              ),
            ),
            TextField(
              style: const TextStyle(color: Colors.black),
              controller: password,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: const Icon(Icons.lock),
                enabled: !state.isLoading,
              ),
            ),
            gapH48,
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    isLoading: state.isLoading,
                    onPressed: state.isLoading ? null : () => _login(),
                    text: 'Login',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
