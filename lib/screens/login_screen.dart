import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../components/reuseable_button.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        child: Image.asset('images/logo.png'),
                        height: 100,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TyperAnimatedTextKit(
                      text: ['Log In'],
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
              TextField(
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kReuseableInputDecoration.copyWith(
                    hintText: 'Enter your email', labelText: 'Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kReuseableInputDecoration.copyWith(
                    hintText: 'Enter your password', labelText: 'Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              ReuseableButton(
                title: 'Log In',
                color: Colors.black,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
