import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login_screen/login_screen.dart';
import 'package:flutter_app/utils/constants.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'New Custom App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: kBackGroundColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kPrimaryColor,
          fontFamily: 'Montserrat',
          ) ,
        ),
        home: const LoginScreen(),
    );
  }
}

