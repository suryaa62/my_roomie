import 'package:flutter/material.dart';
import 'package:my_roomie/core/notifiers/homepage_notifier.dart';
import 'package:my_roomie/ui/views/logo.dart';
import 'package:my_roomie/ui/views/signup_view.dart';

class SignUpSmall extends StatelessWidget {
  const SignUpSmall({Key? key, required this.notifier}) : super(key: key);
  final HomepageNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(alignment: Alignment.centerLeft, child: Logo()),
        Expanded(
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SignUpView(
                signInSubmit: notifier.signin,
                signUpSubmit: notifier.signup,
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
