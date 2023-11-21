import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/presentation/shared/primary_button.dart';
import 'package:split_the_bill/routes.dart';

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

  //final SignInFormType formType;
  @override
  Widget build(BuildContext context) {
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
              decoration: const InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
              ),
            ),
            TextField(
              style: const TextStyle(color: Colors.black),
              controller: password,
              decoration: const InputDecoration(
                prefixIcon:
                    Icon(Icons.lock), //you can use prefixIcon property too.
                labelText: "Password",
              ),
            ),
            gapH48,
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                      isLoading: ref.watch(authStateProvider).isLoading,
                      onPressed: () => ref
                          .read(authStateProvider.notifier)
                          .login(email.text, password.text)
                          .then((value) => context.goNamed(Routes.groups.name)),
                      text: 'Login'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
