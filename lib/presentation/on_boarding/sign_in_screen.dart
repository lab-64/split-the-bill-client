import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';
import 'package:split_the_bill/presentation/shared/components/input_text_field.dart';
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
      authStateProvider,
      (_, next) => next.showSnackBarOnError(context),
    );

    final state = ref.watch(authStateProvider);

    return Scaffold(
      body: _buildSignInBody(state),
    );
  }

  Widget _buildSignInBody(AsyncValue<User> state) {
    return Container(
      decoration: _buildBackgroundDecoration(),
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: Sizes.p24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png'),
              gapH64,
              InputTextField(
                labelText: 'Email*',
                prefixIcon: const Icon(Icons.alternate_email),
                controller: email,
                isLoading: state.isLoading,
              ),
              gapH16,
              InputTextField(
                labelText: 'Password*',
                prefixIcon: const Icon(Icons.lock),
                controller: password,
                isLoading: state.isLoading,
                obscureText: true,
              ),
              gapH48,
              _buildSignInButton(state),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBackgroundDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade300, Colors.blue.shade800],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  Widget _buildSignInButton(AsyncValue<User> state) {
    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            isLoading: state.isLoading,
            onPressed: state.isLoading ? null : () => _login(),
            icon: Icons.login,
            text: 'Login',
            color: Colors.green.shade400,
          ),
        ),
      ],
    );
  }
}
