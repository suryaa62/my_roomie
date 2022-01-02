import 'package:adaptic/adaptive.dart';
import 'package:flutter/material.dart';
import 'package:my_roomie/core/models/room.dart';
import 'package:my_roomie/core/models/room_member.dart';
import 'package:my_roomie/core/notifiers/homepage_notifier.dart';
import 'package:my_roomie/ui/layout/room_page/large.dart';
import 'package:my_roomie/ui/layout/room_page/small.dart';

class RoomPage extends StatelessWidget {
  RoomPage(
      {Key? key,
      required this.notifier,
      required this.room,
      required this.users})
      : super(key: key);
  final HomepageNotifier notifier;
  Room room;
  List<RoomMember> users;

  @override
  Widget build(BuildContext context) {
    return AdaptiveIfScreen<Widget>(
        context: context,
        ifNotSpecified: RoomPageLarge(
          notifier: notifier,
          room: room,
          users: users,
        ),
        ifSmall: RoomPageSmall(
          notifier: notifier,
          room: room,
          users: users,
        ));
  }
}
