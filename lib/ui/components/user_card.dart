import 'package:flutter/material.dart';
import 'package:my_roomie/core/models/user.dart';

class Usercard extends StatelessWidget {
  const Usercard({Key? key, required this.user}) : super(key: key);
  final User user;

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
              width: 78,
              height: 78,
              child: CircleAvatar(
                backgroundColor: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Text(
                user.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 36),
              ),
            ),
            Text(
              user.phone_no,
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 29),
            )
          ],
        ),
      ),
    );
  }
}
