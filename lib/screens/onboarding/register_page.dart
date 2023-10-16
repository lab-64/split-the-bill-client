import 'package:flutter/material.dart';
import 'package:split_the_bill/providers/dummy_authentication.dart';
import 'package:split_the_bill/widgets/screenTitle.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String username = '';

  String email = '';

  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ScreenTitle(
            text: 'Register Page',
          ),
          LoginFormFields(
            onChangedValue: onChangedValue,
          ),
          TextButton(
              onPressed: () {
                if (username.isNotEmpty &&
                    email.isNotEmpty &&
                    password.isNotEmpty) {
                  DummyAuthentication.register(username, email, password);
                  Navigator.popUntil(context, (route) => route.isFirst);
                }
              },
              child: const Text("Register")),
        ],
      ),
      appBar: AppBar(
        leading: const BackButton(),
      ),
    );
  }

  onChangedValue(String type, String value) {
    if (type == 'username')
      username = value;
    else if (type == 'email')
      email = value;
    else if (type == 'password') password = value;
  }
}

class LoginFormFields extends StatelessWidget {
  final Function onChangedValue;

  const LoginFormFields({
    super.key,
    required this.onChangedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your username'),
                onChanged: (value) => {onChangedValue('username', value)},
              ),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter your Email'),
                onChanged: (value) => {onChangedValue('email', value)},
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your Password'),
                onChanged: (value) => {onChangedValue('password', value)},
                obscureText: true,
                obscuringCharacter: "*",
              ),
            ],
          ),
        ));
  }
}
