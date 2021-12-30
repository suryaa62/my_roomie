import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_roomie/core/models/room.dart';
import 'package:my_roomie/core/models/user.dart';
import 'package:my_roomie/core/notifiers/homepage_notifier.dart';
import 'package:my_roomie/ui/components/text_input.dart';
import 'package:my_roomie/ui/components/verify_image.dart';
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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomepageNotifier>(
      create: (context) => HomepageNotifier(),
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            inputDecorationTheme: const InputDecorationTheme(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Color(0xffFCF4DC),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Color(0xffFEBD00)),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Color(0xffFEBD00)),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Color(0xffFEBD00)),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                )),
            textTheme: TextTheme(
                headline1: GoogleFonts.reenieBeanie(
                    textStyle: TextStyle(fontSize: 82, color: Colors.black)),
                bodyText1: GoogleFonts.reemKufi(color: Colors.black))),
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
      body: Builder(builder: (context) {
        if (notifier.state == AuthState.loggedout) {
          return Row(
            children: [
              Expanded(flex: 50, child: Logo()),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400, minWidth: 100),
                child: Center(
                  child: SignUpView(
                    signInSubmit: notifier.signin,
                    signUpSubmit: notifier.signup,
                  ),
                ),
              ),
              Expanded(flex: 50, child: SizedBox())
            ],
          );
        } else if (notifier.state == AuthState.verify) {
          Size size = MediaQuery.of(context).size;
          return Stack(
            children: [
              Container(
                color: Color(0xffFCF4DC),
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
            List<User> users = room.users;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index].name),
                );
              },
            );
          },
        );
      }),
    );
  }
}
