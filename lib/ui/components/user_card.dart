import 'package:adaptic/adaptive.dart';
import 'package:flutter/material.dart';
import 'package:my_roomie/core/models/room_member.dart';
import 'package:my_roomie/core/models/user.dart';

class Usercard extends StatelessWidget {
  const Usercard({Key? key, required this.user}) : super(key: key);
  final RoomMember user;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          side: BorderSide(width: 2, color: Colors.black)),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: AdaptiveIfScreen<double>(
                  context: context, ifNotSpecified: 78, ifSmall: 60),
              height: AdaptiveIfScreen<double>(
                  context: context, ifNotSpecified: 78, ifSmall: 60),
              child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  foregroundImage:
                      AssetImage('lib/assets/avatar_${user.avatar_id}.png')),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: AdaptiveIfScreen<double>(
                      context: context, ifNotSpecified: 50, ifSmall: 0)),
              child: Text(
                user.name,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: AdaptiveIfScreen<double>(
                        context: context, ifNotSpecified: 36, ifSmall: 30)),
              ),
            ),
            Text(
              user.phone_no,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: AdaptiveIfScreen<double>(
                      context: context, ifNotSpecified: 29, ifSmall: 22)),
            )
          ],
        ),
      ),
    );
  }
}
