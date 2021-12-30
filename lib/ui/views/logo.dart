import 'package:flutter/material.dart';
import 'package:my_roomie/ui/components/logo/subtitle.dart';
import 'package:my_roomie/ui/components/logo/title.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTitle(),
        Subtitle(),
      ],
    );
  }
}
