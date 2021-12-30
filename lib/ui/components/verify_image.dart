import 'package:flutter/material.dart';

class VerifyImage extends StatelessWidget {
  VerifyImage({Key? key, required this.height}) : super(key: key);
  double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/assets/Verify_cat.png',
      height: height,
      fit: BoxFit.fitHeight,
    );
  }
}
