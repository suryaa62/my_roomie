import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_roomie/core/models/room.dart';
import 'package:my_roomie/core/models/room_member.dart';
import 'package:my_roomie/core/models/user.dart';
import 'package:my_roomie/core/notifiers/homepage_notifier.dart';
import 'package:my_roomie/ui/components/text_input.dart';
import 'package:my_roomie/ui/components/user_card.dart';
import 'package:my_roomie/ui/components/verify_image.dart';
import 'package:my_roomie/ui/layout/theme.dart';
import 'package:my_roomie/ui/views/header.dart';
import 'package:my_roomie/ui/views/loading.dart';
import 'package:my_roomie/ui/views/logo.dart';
import 'package:my_roomie/ui/views/signup_view.dart';
import 'package:my_roomie/ui/views/verify_continue.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

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
        home: Consumer<HomepageNotifier>(
          builder: (context, value, child) => Homepage(notifier: value),
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
      body: (MediaQuery.of(context).size.width < 700)
          ? Container(
              color: Provider.of<ThemeNotifier>(context).currentTheme.secondary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(33),
                      child: Text(
                        "Please visit from desktop. \nPhone view coming soon!",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  VerifyImage(height: 200)
                ],
              ),
            )
          : Stack(
              children: [
                Builder(builder: (context) {
                  if (notifier.state == AuthState.loggedout) {
                    return ListView(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 50, child: Logo()),
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxWidth: 400, minWidth: 100),
                              child: Center(
                                child: SignUpView(
                                  signInSubmit: notifier.signin,
                                  signUpSubmit: notifier.signup,
                                ),
                              ),
                            ),
                            Expanded(flex: 50, child: SizedBox())
                          ],
                        ),
                      ],
                    );
                  } else if (notifier.state == AuthState.verify) {
                    Size size = MediaQuery.of(context).size;
                    return Stack(
                      children: [
                        Container(
                          color: Provider.of<ThemeNotifier>(context)
                              .currentTheme
                              .secondary,
                        ),
                        Logo(),
                        Positioned(
                            top: size.height * 0.25,
                            right: size.width * 0.50 - 50,
                            child: VerifyImage(
                              height: size.height * 0.75,
                            )),
                        Positioned(
                            left: size.width * 0.50,
                            top: size.height * 0.40,
                            child: VerifyView(onPressed: notifier.reload))
                      ],
                    );
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

                      Room room = Room.fromMap(
                          snapshot.data!.data() as Map<String, dynamic>);
                      List<RoomMember> users = room.users;
                      return ListView(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Header(
                              room: room.block + " - " + room.number,
                              userName: notifier.user!.name,
                              id: notifier.user!.avatar_id),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18, right: 33),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: users.length,
                                      itemBuilder: (context, index) {
                                        if (users[index].uid ==
                                            notifier.user!.uid)
                                          return Container();
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Usercard(user: users[index]),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 33.0, vertical: 22),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${users.length - 1} room ${(users.length - 1 >= 1) ? "mates" : "mate"} found",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 30),
                                      ),
                                      // FloatingActionButton(
                                      //   onPressed: () {},
                                      //   child: Icon(
                                      //     Icons.arrow_forward,
                                      //     color: Colors.white,
                                      //   ),
                                      //   backgroundColor: Colors.black,
                                      // )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20, top: 50),
                            child: SizedBox(
                              width: 300,
                              child: Text(
                                "Made with love by fellow frustrated VITian",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 22,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
                (notifier.isBusy)
                    ? Loading(
                        primary: Provider.of<ThemeNotifier>(context)
                            .currentTheme
                            .primary,
                        secondary: Provider.of<ThemeNotifier>(context)
                            .currentTheme
                            .secondary)
                    : Container()
              ],
            ),
    );
  }
}
