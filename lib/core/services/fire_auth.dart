import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FAuth {
  FAuth() {
    auth = FirebaseAuth.instance;
  }

  void addListner(
      {required Future<void> Function() loggedin,
      required VoidCallback loggedOut,
      required VoidCallback emailVerification,
      required void Function(bool) busy}) {
    auth.userChanges().listen((User? user) async {
      try {
        busy(true);
        if (user == null) {
          loggedOut();
        } else {
          if (!user.emailVerified) {
            await user.sendEmailVerification();

            emailVerification();
          } else {
            await loggedin();
          }
        }
      } catch (e) {
        print(e);
      }
      busy(false);
    });
  }

  late FirebaseAuth auth;

  Future<void> reload() async {
    await auth.currentUser?.reload();
  }

  String getUid() {
    try {
      return auth.currentUser!.uid;
    } catch (e) {
      print(e);
    }
    throw Exception("Error : get uid");
  }

  Future<String> signup(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user!.uid;
    }
    // on FirebaseAuthException catch (e) {
    //   if (e.code == 'weak-password') {
    //     print('The password provided is too weak.');
    //   } else if (e.code == 'email-already-in-use') {
    //     print('The account already exists for that email.');
    //   }
    // }
    catch (e) {
      rethrow;
    }
    // throw Exception("Some Error");
  }

  Future<String> signin(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user!.uid;
    } catch (e) {
      rethrow;
    }
  }
}
