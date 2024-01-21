import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';
import 'package:split_the_bill/presentation/shared/components/primary_button.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // TODO: Used for testing, set only on debug mode
  @override
  void initState() {
    super.initState();
    email.text = "felix@gmail.com";
    password.text = "test";
  }

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
        authStateProvider, (_, next) => next.showSnackBarOnError(context));

    final state = ref.watch(authStateProvider);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: Sizes.p24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png'),
                gapH64,
                TextField(
                  style: const TextStyle(color: Colors.black),
                  controller: email,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Email",
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.alternate_email),
                    enabled: !state.isLoading,
                  ),
                ),
                gapH16,
                TextField(
                  style: const TextStyle(color: Colors.black),
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Password",
                    fillColor: Colors.white,
                    filled: true,
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
                        text: 'Sign In',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
