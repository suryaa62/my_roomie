import 'package:flutter/material.dart';

class RoomTitle extends StatelessWidget {
  const RoomTitle({Key? key, required this.room, required this.userName})
      : super(key: key);
  final String room;
  final String userName;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 33.0, top: 33.0, bottom: 11),
          child: Text(
            room,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 33),
          child: Text(
            "${userName}'s room",
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 29),
          ),
        ),
      ],
    );
  }
}
