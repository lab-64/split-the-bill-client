import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';

import '../../routes.dart';
import '../shared/components/primary_text_button.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // TODO: Used for testing, set only on debug mode
  @override
  void initState() {
    super.initState();
    email.text = "test@gmail.com";
    password.text = "test123...";
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final controller = ref.read(authStateProvider.notifier);

    await controller.register(
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
      body: _buildRegisterBody(state),
    );
  }

  Widget _buildRegisterBody(AsyncValue<User> state) {
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
              gapH16,
              _buildSignInRoute(),
              gapH16,
              _buildRegisterButton(state),
            ],
          ),
        ),
      ),
    );
  }


  GestureDetector _buildSignInRoute(){
    return GestureDetector(
        onTap: () => context.goNamed(
          Routes.signIn.name,
        ),
        child: RichText(
            text: const TextSpan(
              text: "Click here to ",
              children: <TextSpan>[
                TextSpan(text: 'Login', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            )
        )
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

  Widget _buildRegisterButton(AsyncValue<User> state) {
    return Row(
      children: [
        Expanded(
          child: PrimaryTextButton(
            isLoading: state.isLoading,
            onPressed: state.isLoading ? null : () => _register(),
            text: "Register",
          ),
        ),
      ],
    );
  }
}
