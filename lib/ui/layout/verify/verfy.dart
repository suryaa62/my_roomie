import 'package:adaptic/adaptive.dart';
import 'package:flutter/material.dart';
import 'package:my_roomie/core/notifiers/homepage_notifier.dart';

import 'package:my_roomie/ui/layout/verify/large.dart';
import 'package:my_roomie/ui/layout/verify/small.dart';

class Verify extends StatelessWidget {
  const Verify({Key? key, required this.notifier}) : super(key: key);
  final HomepageNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return AdaptiveIfScreen<Widget>(
        context: context,
        ifNotSpecified: VerifyLarge(notifier: notifier),
        ifSmall: VerifySmall(notifier: notifier));
  }
}
