import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:flutter_app/utils/helper_functions.dart';
import 'package:ionicons/ionicons.dart';
import '../animations/change_screen_animation.dart';
import 'bottom_text.dart';
import 'top_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Screens {
  createAccount,
  welcomeBack,
}

class LoginContent extends StatefulWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent>
  with TickerProviderStateMixin {
    late final List<Widget> _createAccountContent;
    late final List<Widget> loginContent;
    final emailController  = TextEditingController();
    final passwordController  = TextEditingController();
    bool _isHidden = true;

  Widget inputField(String hint, IconData iconData) {
    if(hint == 'Email') {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
        child: SizedBox(
            height: 50,
            child: Material(
              elevation: 8,
              shadowColor: Colors.black87,
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              child: TextField(
                controller: emailController,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: hint,
                  prefixIcon: Icon(iconData),
                ),
              ),
            )),
      );
    }
      else if (hint == 'Password') {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
        child: SizedBox(
            height: 50,
            child: Material(
              elevation: 8,
              shadowColor: Colors.black87,
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              child: TextField(
                obscureText: _isHidden,
                controller: passwordController,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: hint,
                  prefixIcon: Icon(iconData),
                  suffixIcon: IconButton(
                        icon: Icon(
                            _isHidden ? Icons.visibility : Icons.visibility_off),
                        onPressed: _togglePasswordView
                        )),
                  // suffix: InkWell(
                  //   onTap: _togglePasswordView,
                  //   child:
                  //   Icon(
                  //     _isHidden
                  //         ? Icons.visibility
                  //         : Icons.visibility_off,
                  //   ),
                  // ),
                //),
                ),
                ),
              ),
      );
    }else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
        child: SizedBox(
            height: 50,
            child: Material(
              elevation: 8,
              shadowColor: Colors.black87,
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              child: TextField(
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: hint,
                  prefixIcon: Icon(iconData),
                ),
              ),
            )),
      );
    }

  }

  Future _togglePasswordView() async{
    this.setState(() {
      _isHidden = !_isHidden;
    });
  }

  Widget loginButton(String title)  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 16),
      child: ElevatedButton(
        onPressed: signIn,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: const StadiumBorder(),
          elevation: 8,
          shadowColor: Colors.black87,
        ),
        child: Text(title),
      ),
    );
  }
    Widget signupButton(String title)  {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 16),
        child: ElevatedButton(
          onPressed: signUp,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: const StadiumBorder(),
            elevation: 8,
            shadowColor: Colors.black87,
          ),
          child: Text(title),
        ),
      );
    }



  Widget orDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 1,
              color: kPrimaryColor,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'or',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Flexible(
            child: Container(
              height: 1,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget logos() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Image.asset('assets/images/facebook.png'),
      //     const SizedBox(width: 5 ),
      //     Image.asset('assets/images/google.png'),
      //   ],
      // ),
      child: SizedBox(
        height: 50,
        width: 70,
        child: SizedBox(
          height: 40.0,
          width: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 5),
              Image.asset('assets/images/facebook.png'),
              const SizedBox(width: 5),
              Image.asset('assets/images/google.png'),
            ],
          ),
        ),
      ),
    );
  }

  Widget forgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 110),
      child: TextButton(
        onPressed: () {},
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: kSecondaryColor,
          ),
        ),
      ),
    );
  }


  @override
  void initState() {
    _createAccountContent = [
      inputField('Name', Ionicons.person_outline),
      inputField('Email', Ionicons.mail_outline),
      inputField('Password', Ionicons.lock_closed_outline),
      signupButton('Sign Up'),
      orDivider(),
      logos(),
    ];

    loginContent = [
      inputField('Email', Ionicons.mail_outline),
      inputField('Password', Ionicons.lock_closed_outline),
      loginButton('Log In'),
      forgotPassword(),
    ];

    ChangeScreenAnimation.initialize(
      vsync: this,
      createAccountItems: _createAccountContent.length,
      loginItems: loginContent.length,
    );
    for (var i = 0; i < _createAccountContent.length; i++) {
      _createAccountContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.createAccountAnimations[i],
        child: _createAccountContent[i],
      );
    }

    for (var i = 0; i < loginContent.length; i++) {
      loginContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.loginAnimations[i],
        child: loginContent[i],
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    ChangeScreenAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: 130,
          left: 24,
          child: TopText(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _createAccountContent,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: loginContent,
              ),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: BottomText(),
          ),
        )
      ],
    );
  }

    Future signIn() async {
    showDialog(context: context,
        builder: (context)=> Center(child:
          CircularProgressIndicator()
        ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email:
      // '123@gmail.com',
      // '123456'
      emailController.text.trim(),
        password:  passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
      navigatorKey.currentState!.popUntil((route)=> route.isFirst);
    }

    Future signUp() async {
      showDialog(context: context,
        builder: (context)=> Center(child:
        CircularProgressIndicator()
        ),
      );
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email:
        // '123@gmail.com',
        // '123456'
        emailController.text.trim(),
          password:  passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        print(e);
      }
      navigatorKey.currentState!.popUntil((route)=> route.isFirst);
    }
}
