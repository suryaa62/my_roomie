class RoomMember {
  RoomMember({
    required this.name,
    required this.avatar_id,
    required this.phone_no,
    required this.uid,
  });

  String name;
  int avatar_id;
  String phone_no;
  String uid;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "avatar_id": avatar_id,
      "phone": phone_no,
      "uid": uid,
    };
  }

  factory RoomMember.fromMap(Map<String, dynamic> m) {
    return RoomMember(
      avatar_id: m['avatar_id'],
      name: m['name'],
      phone_no: m['phone'],
      uid: m['uid'],
    );
  }
}
