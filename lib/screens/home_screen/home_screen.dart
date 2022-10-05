import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'dart:math' as math;

import '../login_screen/components/center_widget/center_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: -160, left: -30, child: topHomeWidget(screenSize.width)),
          Positioned(
            top: -180,
            left: -40,
            child: bottomHomeWidget(screenSize.width),
          ),
          CenterWidget(size: screenSize),
          Positioned(
            top: 0,
            left: -40,
            child: WelcomeWidget(screenSize.width),
          ),
          Positioned(
            child: logOutWidget(user),
          ),
        ],
      ),
    );
  }

  Widget topHomeWidget(double screenWidth) {
    return Transform.rotate(
      angle: -35 * math.pi / 180,
      child: Container(
        width: 1.2 * screenWidth,
        height: 1.2 * screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
            gradient: const LinearGradient(
                begin: Alignment(-0.2, 0 - 8),
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x007CBFCF),
                  Color(0xB316BFC4),
                ])),
      ),
    );
  }

  Widget logOutWidget(User user) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Signed In as',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            user.email!,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 40),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
            ),
            icon: Icon(Icons.arrow_back, size: 32),
            label: Text(
              'Sign Out',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () {
              logOut();
            },
          )
        ],
      ),
    );
  }

  Widget bottomHomeWidget(double screenWidth) {
    return Container(
      width: 1.5 * screenWidth,
      height: 1.5 * screenWidth,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment(0.6, -1.1),
              end: Alignment(0.7, 0.8),
              colors: [
                Color(0xDB4BE8CC),
                Color(0x005CDBCF),
              ])),
    );
  }

  Widget WelcomeWidget(double screenWidth) {
    return Container(
      width: 1.5 * screenWidth,
      height: 1.5 * screenWidth,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment(0.6, -1.1),
              end: Alignment(0.7, 0.8),
              colors: [
                Color(0xDB4BE8CC),
                Color(0x005CDBCF),
              ])),
    );
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
