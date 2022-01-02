import 'package:flutter/material.dart';
import 'package:my_roomie/core/notifiers/homepage_notifier.dart';
import 'package:my_roomie/ui/views/logo.dart';
import 'package:my_roomie/ui/views/signup_view.dart';

class SignUpWeb extends StatelessWidget {
  const SignUpWeb({Key? key, required this.notifier}) : super(key: key);
  final HomepageNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 50, child: Logo()),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400, minWidth: 100),
              child: Center(
                child: SignUpView(
                  signInSubmit: notifier.signin,
                  signUpSubmit: notifier.signup,
                ),
              ),
            ),
            Expanded(flex: 50, child: SizedBox())
          ],
        ),
      ],
    );
  }
}
