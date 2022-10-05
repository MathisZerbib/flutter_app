import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home_screen/home_screen.dart';
import 'package:flutter_app/screens/login_screen/login_screen.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'New Custom App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackGroundColor,
        textTheme: Theme
            .of(context)
            .textTheme
            .apply(bodyColor: kPrimaryColor,
          fontFamily: 'Montserrat',
        ),
      ),
      home: MainPage(),
    );
  }
}
  class MainPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) =>
        Scaffold(
          body: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MaterialApp(
                      home: HomeScreen()
                  );
                } else {
                  return MaterialApp(home: LoginScreen());
                }
              }
          ),
        );
  }