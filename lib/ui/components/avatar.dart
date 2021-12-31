import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  Avatar(
      {Key? key,
      required this.radius,
      required this.id,
      required this.callback,
      required this.color})
      : super(key: key);
  double radius;
  int id;
  VoidCallback callback;
  Color color;

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
                backgroundColor: Colors.white,
                foregroundImage: AssetImage('lib/assets/avatar_$id.png')),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              elevation: 0,
              shape: CircleBorder(side: BorderSide(color: color)),
              mini: true,
              child: Icon(
                Icons.casino,
                color: color,
              ),
              backgroundColor: Colors.white,
              onPressed: () {
                callback();
              },
            ),
          )
        ],
      ),
    );
  }
}
