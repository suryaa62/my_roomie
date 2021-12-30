import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 33.0, top: 33.0, bottom: 11),
      child: Text(
        "My Roomie",
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
