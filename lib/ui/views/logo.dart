import 'package:adaptic/adaptive.dart';
import 'package:flutter/material.dart';
import 'package:my_roomie/ui/components/logo/subtitle.dart';
import 'package:my_roomie/ui/components/logo/title.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveIfScreen(
        context: context,
        ifNotSpecified: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTitle(),
            Subtitle(),
          ],
        ),
        ifSmall: Padding(
          padding: const EdgeInsets.only(left: 24.0, top: 24, bottom: 20),
          child: Text(
            "My Roomie",
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 50),
          ),
        ));
  }
}
