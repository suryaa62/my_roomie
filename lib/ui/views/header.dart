import 'package:adaptic/adaptive.dart';
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
    return AdaptiveIfScreen(
        context: context,
        ifNotSpecified: Stack(
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
                        foregroundImage:
                            AssetImage('lib/assets/avatar_$id.png')),
                  ),
                  alignment: Alignment.center,
                )),
          ],
        ),
        ifSmall: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Logo(), RoomTitle(room: room, userName: userName)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Divider(
                    color: Colors.black,
                  ),
                )),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      foregroundImage: AssetImage('lib/assets/avatar_$id.png')),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Divider(
                    color: Colors.black,
                  ),
                )),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "${userName}'s room",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 20),
                ),
              ),
            ),
          ],
        ));
  }
}
