import 'package:adaptic/adaptive.dart';
import 'package:flutter/material.dart';
import 'package:my_roomie/core/notifiers/homepage_notifier.dart';
import 'package:my_roomie/ui/layout/sign_up/large.dart';
import 'package:my_roomie/ui/layout/sign_up/small.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key, required this.notifier}) : super(key: key);
  final HomepageNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return AdaptiveIfScreen<Widget>(
        context: context,
        ifNotSpecified: SignUpWeb(notifier: notifier),
        ifSmall: SignUpSmall(notifier: notifier));
  }
}
