import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:flutter/material.dart';
import '../components/reuseable_button.dart';
import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'RegistrationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                    flex: 2,
                    child: TyperAnimatedTextKit(
                      text: ['Registration'],
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
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kReuseableInputDecoration.copyWith(
                    hintText: 'Enter your name', labelText: 'Name'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
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
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kReuseableInputDecoration.copyWith(
                    hintText: 'Enter your phone Number', labelText: 'Phone'),
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Gender',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: GenderPickerWithImage(
                      verticalAlignedText: false,
                      selectedGender: Gender.Male,
                      selectedGenderTextStyle: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                      unSelectedGenderTextStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                      onChanged: (Gender gender) {
                        print(gender);
                      },
                      equallyAligned: true,
                      animationDuration: Duration(milliseconds: 300),
                      isCircular: true,
                      // default : true,
                      opacityOfGradient: 0.4,
                      padding: const EdgeInsets.all(3),
                      size: 50, //default : 40
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
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
                title: 'Register',
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
