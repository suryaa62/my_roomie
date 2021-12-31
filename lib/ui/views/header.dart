import 'package:flutter/material.dart';
import 'package:my_roomie/ui/components/avatar.dart';
import 'package:my_roomie/ui/components/room_title.dart';
import 'package:my_roomie/ui/layout/theme.dart';
import 'package:my_roomie/ui/views/logo.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header(
      {Key? key, required this.room, required this.userName, required this.id})
      : super(key: key);
  final String room;
  final String userName;
  final int id;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Logo(),
            Expanded(
              child: SizedBox(),
              flex: 50,
            ),
            // Avatar(radius: 50),
            // Expanded(
            //   child: SizedBox(),
            //   flex: 50,
            // ),
            RoomTitle(room: room, userName: userName),
          ],
        ),
        Positioned(
            top: 33,
            left: size.width / 2 - 50,
            child: Align(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    foregroundImage: AssetImage('lib/assets/avatar_$id.png')),
              ),
              alignment: Alignment.center,
            )),
      ],
    );
  }
}
