import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_roomie/core/models/room.dart';
import 'package:my_roomie/core/models/user.dart';

class Fstore {
  Fstore() {
    db = FirebaseFirestore.instance;
    _users = db.collection('users');
    _rooms = db.collection('rooms');
  }
  late FirebaseFirestore db;
  late CollectionReference _users;
  late CollectionReference _rooms;
  late Stream<DocumentSnapshot> _roomDocstream;

  Future<void> addUser(User user, Room room) async {
    try {
      await _users.doc(user.uid).set(user.toMap());
      DocumentSnapshot doc = await _rooms.doc(user.room_id).get();
      if (doc.exists) {
        await _rooms.doc(user.room_id).update({
          'users': FieldValue.arrayUnion([user.toMap()])
        });
      } else {
        await _rooms.doc(user.room_id).set(room.toMap());
      }
      _roomDocstream = db.collection('rooms').doc(user.room_id).snapshots();
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getUserDetails(String uid) async {
    try {
      DocumentSnapshot doc = await _users.doc(uid).get();
      User user = User.fromMap(doc.data() as Map<String, dynamic>);
      _roomDocstream = db.collection('rooms').doc(user.room_id).snapshots();
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Stream<DocumentSnapshot> roomStream(String room_id) {
    //_roomDocstream = _rooms.doc(room_id).snapshots();
    return _roomDocstream;
  }
}
