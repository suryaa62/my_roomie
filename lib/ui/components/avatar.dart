import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  Avatar({Key? key, required this.radius}) : super(key: key);
  double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 2 * radius,
      width: 2 * radius,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              maxRadius: radius,
              backgroundColor: Colors.amber,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.cyanAccent,
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
