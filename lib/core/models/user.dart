class User {
  User(
      {required this.name,
      required this.email,
      required this.avatar_id,
      required this.room_id,
      required this.phone_no,
      required this.uid});

  String name;
  String email;
  int avatar_id;
  String room_id;
  String phone_no;
  String uid;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "avatar_id": avatar_id,
      "room_id": room_id,
      "phone": phone_no,
      "uid": uid,
    };
  }

  factory User.fromMap(Map<String, dynamic> m) {
    return User(
        avatar_id: m['avatar_id'],
        email: m['email'],
        name: m['name'],
        phone_no: m['phone'],
        room_id: m['room_id'],
        uid: m['uid']);
  }
}
