import 'package:flutter/material.dart';
import 'package:my_roomie/core/models/room.dart';
import 'package:my_roomie/core/models/room_member.dart';
import 'package:my_roomie/core/notifiers/homepage_notifier.dart';
import 'package:my_roomie/ui/components/user_card.dart';
import 'package:my_roomie/ui/views/header.dart';

class RoomPageLarge extends StatelessWidget {
  RoomPageLarge(
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
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Header(
            room: room.block + " - " + room.number,
            userName: notifier.user!.name,
            id: notifier.user!.avatar_id),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, right: 33),
                  child: (users.length - 1 == 0)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 128,
                                height: 128,
                                child: CircleAvatar(
                                  radius: 64,
                                  foregroundImage:
                                      AssetImage('lib/assets/sad_cat.png'),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "Don't worry!!!\nShare the website to find your room mates.",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 25),
                              ),
                            )
                          ],
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            if (users[index].uid == notifier.user!.uid)
                              return Container();
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Usercard(user: users[index]),
                            );
                          },
                        ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 33.0, vertical: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${users.length - 1} room ${(users.length - 1 > 1) ? "mates" : "mate"} found",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 30),
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
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 50),
          child: SizedBox(
            width: 300,
            child: Text(
              "Made with love by fellow frustrated VITian",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 22,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
