import 'package:flutter/material.dart';
import 'package:my_roomie/core/notifiers/homepage_notifier.dart';
import 'package:my_roomie/ui/components/verify_image.dart';
import 'package:my_roomie/ui/views/logo.dart';
import 'package:my_roomie/ui/views/verify_continue.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class VerifyLarge extends StatelessWidget {
  const VerifyLarge({Key? key, required this.notifier}) : super(key: key);
  final HomepageNotifier notifier;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          color: Provider.of<ThemeNotifier>(context).currentTheme.secondary,
        ),
        Logo(),
        Positioned(
            top: size.height * 0.25,
            right: size.width * 0.50 - 50,
            child: VerifyImage(
              height: size.height * 0.75,
            )),
        Positioned(
            left: size.width * 0.50,
            top: size.height * 0.40,
            child: VerifyView(onPressed: notifier.reload))
      ],
    );
  }
}
