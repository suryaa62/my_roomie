import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_roomie/core/models/room.dart';
import 'package:my_roomie/core/models/room_member.dart';
import 'package:my_roomie/core/models/user.dart';
import 'package:my_roomie/core/services/fire_auth.dart';
import 'package:my_roomie/core/services/fire_store.dart';

class HomepageNotifier extends ChangeNotifier {
  HomepageNotifier() {
    authService = FAuth();
    authService.addListner(
        loggedin: loggedin,
        loggedOut: loggedOut,
        emailVerification: emailVerifying,
        busy: this.busy);
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

  Future<void> loggedin() async {
    try {
      if (user == null) {
        String uid = authService.getUid();
        user = await dbService.getUserDetails(uid);
      }
      state = AuthState.loggedin;

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void emailVerifying() {
    state = AuthState.verify;
    notifyListeners();
  }

  void loggedOut() {
    state = AuthState.loggedout;
    notifyListeners();
  }

  Future<void> signup(
      String email,
      String password,
      String name,
      String phone_no,
      String block,
      String room_no,
      int id,
      bool annex,
      String gender) async {
    try {
      busy(true);
      String uid = await authService.signup(email, password);
      user = User(
          avatar_id: id,
          email: email,
          phone_no: phone_no,
          name: name,
          uid: uid,
          room_id:
              block + "_" + annex.toString() + "_" + gender + "_" + room_no,
          gender: gender,
          isAnnex: annex);
      room = Room(
          block: block,
          number: room_no,
          users: [
            RoomMember(name: name, avatar_id: id, phone_no: phone_no, uid: uid)
          ],
          gender: gender,
          annex: annex);
      await dbService.addUser(user!, room);
    } catch (e) {
      rethrow;
    } finally {
      busy(false);
    }
  }

  Future<void> reload() async {
    try {
      busy(true);
      await authService.reload();
    } catch (e) {
      rethrow;
    } finally {
      busy(false);
    }
  }

  Future<void> signin(String email, String password) async {
    try {
      busy(true);
      String uid = await authService.signin(email, password);
      user = await dbService.getUserDetails(uid);
    } catch (e) {
      rethrow;
    } finally {
      busy(false);
    }
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
