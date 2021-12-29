import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_roomie/core/models/room.dart';
import 'package:my_roomie/core/models/user.dart';
import 'package:my_roomie/core/services/fire_auth.dart';
import 'package:my_roomie/core/services/fire_store.dart';

class HomepageNotifier extends ChangeNotifier {
  HomepageNotifier() {
    authService = FAuth();
    authService.addListner(
        loggedin: loggedin,
        loggedOut: loggedOut,
        emailVerification: emailVerifying);
    dbService = Fstore();
  }
  late FAuth authService;
  late Fstore dbService;
  bool isBusy = false;
  AuthState state = AuthState.loggedout;
  User? user;
  late Room room;

  void busy(bool x) {
    isBusy = x;
    notifyListeners();
  }

  void loggedin() async {
    state = AuthState.loggedin;
    if (user == null) {
      String uid = authService.getUid();
      user = await dbService.getUserDetails(uid);
    }
    notifyListeners();
  }

  void emailVerifying() {
    state = AuthState.verify;
    notifyListeners();
  }

  void loggedOut() {
    state = AuthState.loggedout;
    notifyListeners();
  }

  void signup(String email, String password, String name, String phone_no,
      String block, String room_no) async {
    busy(true);
    String uid = await authService.signup(email, password);
    user = User(
        avatar_id: 1,
        email: email,
        phone_no: phone_no,
        name: name,
        uid: uid,
        room_id: block + "_" + room_no);
    room = Room(block: block, number: room_no, users: [user!]);
    await dbService.addUser(user!, room);

    busy(false);
  }

  void reload() async {
    busy(true);
    await authService.reload();
    busy(false);
  }

  void signin(String email, String password) async {
    busy(true);
    String uid = await authService.signin(email, password);
    user = await dbService.getUserDetails(uid);
    busy(false);
  }

  Stream<DocumentSnapshot> getRoom() {
    return dbService.roomStream(user!.room_id);
  }
}

enum AuthState {
  loggedin,
  loggedout,
  verify,
}
