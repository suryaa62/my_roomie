import 'package:my_roomie/core/models/room_member.dart';
import 'package:my_roomie/core/models/user.dart';

class Room {
  Room(
      {required this.block,
      required this.number,
      required this.users,
      required this.annex,
      required this.gender});

  String block;
  String number;
  bool annex;
  String gender;
  List<RoomMember> users;

  Map<String, dynamic> toMap() {
    return {
      "block": block,
      "number": number,
      "users": [for (RoomMember user in users) user.toMap()],
      "annex": annex,
      "gender": gender
    };
  }

  factory Room.fromMap(
    Map<String, dynamic> m,
  ) {
    return Room(
        number: m['number'],
        block: m['block'],
        gender: m['gender'],
        annex: m['annex'],
        users: [
          for (Map<String, dynamic> user in m['users']) RoomMember.fromMap(user)
        ]);
  }
}
