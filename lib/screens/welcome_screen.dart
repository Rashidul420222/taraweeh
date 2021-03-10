import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../screens/login_screen.dart';
import '../screens/registration_screen.dart';
import '../components/reuseable_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    animation = ColorTween(begin: Colors.white70, end: Colors.white)
        .animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 250,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: WavyAnimatedTextKit(
                    text: ['Taraweeh Namaj'],
                    textStyle: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
                    isRepeatingAnimation: true,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            ReuseableButton(
              title: 'Log In',
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pushNamed(LoginScreen.id);
              },
            ),
            ReuseableButton(
              title: 'Registration',
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pushNamed(RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
