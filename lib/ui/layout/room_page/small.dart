import 'package:flutter/material.dart';
import 'package:my_roomie/core/models/room.dart';
import 'package:my_roomie/core/models/room_member.dart';
import 'package:my_roomie/core/notifiers/homepage_notifier.dart';
import 'package:my_roomie/ui/components/user_card.dart';
import 'package:my_roomie/ui/views/header.dart';

class RoomPageSmall extends StatelessWidget {
  RoomPageSmall(
      {Key? key,
      required this.notifier,
      required this.room,
      required this.users})
      : super(key: key);
  HomepageNotifier notifier;
  Room room;
  List<RoomMember> users;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header(
            room: room.block + " - " + room.number,
            userName: notifier.user!.name,
            id: notifier.user!.avatar_id),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5),
          child: Text(
            "${users.length - 1} room ${(users.length - 1 > 1) ? "mates" : "mate"} found",
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: (users.length - 1 == 0)
                ? ListView(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                            width: 128,
                            height: 128,
                            child: CircleAvatar(
                              radius: 64,
                              foregroundImage:
                                  AssetImage('lib/assets/sad_cat.png'),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Don't worry!!!\nShare the website to find your room mates.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 25),
                        ),
                      )
                    ],
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      if (users[index].uid == notifier.user!.uid)
                        return Container();
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Usercard(user: users[index]),
                      );
                    },
                  ),
          ),
        ),

        // FloatingActionButton(
        //   onPressed: () {},
        //   child: Icon(
        //     Icons.arrow_forward,
        //     color: Colors.white,
        //   ),
        //   backgroundColor: Colors.black,
        // )
      ],
    );
  }
}
