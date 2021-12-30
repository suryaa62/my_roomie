import 'package:flutter/material.dart';

class Subtitle extends StatelessWidget {
  const Subtitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 33),
      child: Text(
        "Forget all those whatsapp groups",
        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 29),
      ),
    );
  }
}
