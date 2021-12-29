import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_roomie/core/models/room.dart';
import 'package:my_roomie/core/models/user.dart';
import 'package:my_roomie/core/notifiers/homepage_notifier.dart';
import 'package:my_roomie/ui/components/text_input.dart';
import 'package:my_roomie/ui/views/signup_view.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

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
        ),
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
          return SignUpView(
            signInSubmit: notifier.signin,
            signUpSubmit: notifier.signup,
          );
        } else if (notifier.state == AuthState.verify) {
          return Column(
            children: [
              Center(
                child: Text("Please verify your email "),
              ),
              ElevatedButton(
                  onPressed: () {
                    notifier.reload();
                  },
                  child: Text("Continiue"))
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
