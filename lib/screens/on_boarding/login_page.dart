import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:split_the_bill/providers/dummy_data_calls.dart';
import 'package:split_the_bill/screens/on_boarding/register_page.dart';
import 'package:split_the_bill/widgets/screen_title.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.dummyCalls}) : super(key: key);

  final DummyDataCalls dummyCalls;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String username = '';

  late String email = '';

  late String password = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          children: [
            const ScreenTitle(
              text: 'Login Page',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Do not have an account yet?"),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                      onPressed: () => {
                            PersistentNavBarNavigator.pushNewScreen(context,
                                screen:
                                    RegisterPage(dummyCalls: widget.dummyCalls))
                          },
                      child: const Icon(Icons.app_registration)),
                )
              ],
            ),
            LoginFormFields(
              onChangedValue: onChangedValue,
            ),
            TextButton(
                onPressed: () {
                  if (username.isNotEmpty && password.isNotEmpty) {
                    if (widget.dummyCalls.login(username, password)) {
                      Navigator.pop(context);
                    } else {
                      //TODO add error message
                    }
                  }
                },
                child: const Text("Login")),
          ],
        ),
      ),
    );
  }

  onChangedValue(String type, String value) {
    if (type == 'username') {
      username = value;
    } else if (type == 'password') {
      password = value;
    }
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
