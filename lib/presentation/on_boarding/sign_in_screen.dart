import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';
import 'package:split_the_bill/presentation/shared/components/input_text_form_field.dart';
import 'package:split_the_bill/presentation/shared/components/primary_button.dart';
import 'package:split_the_bill/router/routes.dart';

import '../shared/auth_validation.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _signInFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_signInFormKey.currentState!.validate()) {
      final controller = ref.read(authStateProvider.notifier);

      await controller.login(
        email: email.text,
        password: password.text,
      );
    }
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              gapH32,
              Image.asset('assets/SplitIt-Name-Transparent.png',
                  width: (MediaQuery.of(context).size.width) * .7),
              gapH32,
              const Text(
                "Login",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Sizes.p32,
                  color: Colors.white,
                ),
              ),
              gapH16,
              Form(
                  key: _signInFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InputTextFormField(
                        labelText: 'Email*',
                        prefixIcon: const Icon(Icons.alternate_email),
                        controller: email,
                        isLoading: state.isLoading,
                        validator: (value) => validateEmail(value),
                      ),
                      gapH16,
                      InputTextFormField(
                        labelText: 'Password*',
                        prefixIcon: const Icon(Icons.lock),
                        controller: password,
                        isLoading: state.isLoading,
                        obscureText: true,
                        validator: (value) => validatePassword(value),
                      ),
                      gapH16,
                      _buildSignInButton(state),
                      gapH16,
                      _buildRegisterRoute(),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _buildRegisterRoute() {
    return GestureDetector(
      onTap: () => const RegisterRoute().go(context),
      child: RichText(
        text: const TextSpan(
          text: "Click here to ",
          children: <TextSpan>[
            TextSpan(
                text: 'Register',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        textScaler: const TextScaler.linear(1.3),
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
            backgroundColor: Colors.green.shade400,
            text: 'Login',
          ),
        ),
      ],
    );
  }
}
