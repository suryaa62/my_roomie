import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_roomie/core/models/room.dart';
import 'package:my_roomie/core/models/room_member.dart';
import 'package:my_roomie/core/models/user.dart';
import 'package:my_roomie/core/notifiers/homepage_notifier.dart';
import 'package:my_roomie/ui/components/text_input.dart';
import 'package:my_roomie/ui/components/user_card.dart';
import 'package:my_roomie/ui/components/verify_image.dart';
import 'package:my_roomie/ui/layout/room_page/roompage.dart';
import 'package:my_roomie/ui/layout/sign_up/signup.dart';
import 'package:my_roomie/ui/layout/theme.dart';
import 'package:my_roomie/ui/layout/verify/verfy.dart';
import 'package:my_roomie/ui/views/header.dart';
import 'package:my_roomie/ui/views/loading.dart';
import 'package:my_roomie/ui/views/logo.dart';
import 'package:my_roomie/ui/views/signup_view.dart';
import 'package:my_roomie/ui/views/verify_continue.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adaptic/adaptive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<HomepageNotifier>(
        create: (context) => HomepageNotifier(),
      ),
      ChangeNotifierProvider<ThemeNotifier>(
        create: (context) => ThemeNotifier(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, value, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: value.currentTheme.data,
        home: AdaptiveData(
          smallScreenBreakpoint: 800,
          child: Consumer<HomepageNotifier>(
            builder: (context, value, child) => Homepage(notifier: value),
          ),
        ),
      ),
    );
  }
}

class Homepage extends StatelessWidget {
  Homepage({Key? key, required this.notifier}) : super(key: key);
  HomepageNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Builder(builder: (context) {
            if (notifier.state == AuthState.loggedout) {
              return SignUp(notifier: notifier);
            } else if (notifier.state == AuthState.verify) {
              return Verify(notifier: notifier);
            }
            Provider.of<ThemeNotifier>(context, listen: false)
                .setCurrentTheme(notifier.user!.avatar_id - 1);
            return StreamBuilder<DocumentSnapshot>(
              stream: notifier.getRoom(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Code phat gya!!"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                print(snapshot.data);

                Room room =
                    Room.fromMap(snapshot.data!.data() as Map<String, dynamic>);
                List<RoomMember> users = room.users;
                return RoomPage(notifier: notifier, room: room, users: users);
              },
            );
          }),
          (notifier.isBusy)
              ? Loading(
                  primary:
                      Provider.of<ThemeNotifier>(context).currentTheme.primary,
                  secondary: Provider.of<ThemeNotifier>(context)
                      .currentTheme
                      .secondary)
              : Container()
        ],
      ),
    );
  }
}
