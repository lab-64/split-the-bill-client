import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/infrastructure/async_value_ui.dart';
import 'package:split_the_bill/presentation/shared/components/primary_button.dart';
import 'package:split_the_bill/router/routes.dart';

import '../shared/auth_validation.dart';
import '../shared/components/input_text_form_field.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _registerFormKey = GlobalKey<FormState>();

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
    if (_registerFormKey.currentState!.validate()) {
      final controller = ref.read(authStateProvider.notifier);

      await controller.register(
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
      body: _buildRegisterInBody(state),
    );
  }

  Widget _buildRegisterInBody(AsyncValue<User> state) {
    return Container(
      decoration: _buildBackgroundDecoration(),
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: Sizes.p24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/STB_logo_transparent.png',
                  width: (MediaQuery.of(context).size.width) * 0.5),
              gapH12,
              const Text(
                "Register",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Sizes.p32,
                  color: Colors.white,
                ),
              ),
              gapH64,
              Form(
                  key: _registerFormKey,
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
                      _buildRegisterButton(state),
                      gapH16,
                      _buildSignInRoute(),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _buildSignInRoute() {
    return GestureDetector(
      onTap: () => const LoginRoute().go(context),
      child: RichText(
        text: const TextSpan(
          text: "Click here to ",
          children: <TextSpan>[
            TextSpan(
              text: 'Login',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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

  Widget _buildRegisterButton(AsyncValue<User> state) {
    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            isLoading: state.isLoading,
            onPressed: state.isLoading ? null : () => _register(),
            icon: Icons.app_registration,
            backgroundColor: Colors.green.shade400,
            text: 'Register',
          ),
        ),
      ],
    );
  }
}
