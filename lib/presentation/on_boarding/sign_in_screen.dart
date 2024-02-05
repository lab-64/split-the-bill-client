import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/auth/user.dart';
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
              _buildEmailTextField(state),
              gapH16,
              _buildPasswordTextField(state),
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

  TextField _buildEmailTextField(AsyncValue<User> state) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      controller: email,
      decoration: _buildInputDecoration(
        "Email",
        Icons.alternate_email,
        state.isLoading,
      ),
    );
  }

  TextField _buildPasswordTextField(AsyncValue<User> state) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      controller: password,
      obscureText: true,
      decoration: _buildInputDecoration(
        "Password",
        Icons.lock,
        state.isLoading,
      ),
    );
  }

  InputDecoration _buildInputDecoration(
    String labelText,
    IconData prefixIcon,
    bool isLoading,
  ) {
    return InputDecoration(
      border: InputBorder.none,
      labelText: labelText,
      fillColor: Colors.white,
      filled: true,
      prefixIcon: Icon(prefixIcon),
      enabled: !isLoading,
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
          ),
        ),
      ],
    );
  }
}
