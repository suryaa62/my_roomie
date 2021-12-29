import 'package:my_roomie/core/models/user.dart';

class Room {
  Room({required this.block, required this.number, required this.users});

  String block;
  String number;
  List<User> users;

  Map<String, dynamic> toMap() {
    return {
      "block": block,
      "number": number,
      "users": [for (User user in users) user.toMap()],
    };
  }

  factory Room.fromMap(
    Map<String, dynamic> m,
  ) {
    return Room(number: m['number'], block: m['block'], users: [
      for (Map<String, dynamic> user in m['users']) User.fromMap(user)
    ]);
  }
}
