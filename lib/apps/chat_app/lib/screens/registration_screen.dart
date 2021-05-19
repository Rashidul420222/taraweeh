import 'dart:core';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../screens/chat_screen.dart';
import '../components/reuseable_button.dart';
import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'RegistrationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String name, email, phoneNumber, password;
  Gender genders;
  bool loadding = false, _obscureText = true;
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _users = FirebaseFirestore.instance.collection('users');
  final _nameControler = TextEditingController();
  final _emailControler = TextEditingController();
  final _phoneControler = TextEditingController();
  final _passwordControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> addUser() async {
    return await _users
        .add({
          'name': name,
          'phone': phoneNumber,
          'gender': genders.toString(),
        })
        .then((value) => print(value))
        .catchError((error) => print(error));
  }

  @override
  void dispose() {
    _nameControler.dispose();
    _emailControler.dispose();
    _phoneControler.dispose();
    _passwordControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: loadding,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 100.0),
            child: Form(
              key: _formKey,
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
                  TextFormField(
                    controller: _nameControler,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    validator: (value) =>
                        value.isEmpty ? 'Please Enter your full name' : null,
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: kReuseableInputDecoration.copyWith(
                        prefixIcon: Icon(Icons.face),
                        hintText: 'Enter your full name',
                        labelText: 'Name'),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: _emailControler,
                    textInputAction: TextInputAction.next,
                    validator: (value) => !value.contains('@')
                        ? 'Please enter a valid email addres'
                        : null,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kReuseableInputDecoration.copyWith(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Enter your valid email',
                        labelText: 'Email'),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: _phoneControler,
                    validator: (value) =>
                        value.isEmpty ? 'Please enter your phone number' : null,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    decoration: kReuseableInputDecoration.copyWith(
                        prefixIcon: Icon(Icons.phone),
                        hintText: 'Enter your phone Number',
                        labelText: 'Phone'),
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
                          selectedGender: genders,
                          selectedGenderTextStyle: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                          unSelectedGenderTextStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                          onChanged: (value) {
                            genders = value;
                            print(genders);
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
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _passwordControler,
                    obscureText: _obscureText,
                    validator: (value) => value.length < 6
                        ? 'Please enter your password minimum 6 character'
                        : null,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kReuseableInputDecoration.copyWith(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(_obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        hintText: 'Enter your password',
                        labelText: 'Password'),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  ReuseableButton(
                    title: 'Register',
                    color: Colors.black,
                    onPressed: () async {
                      setState(() {
                        loadding = true;
                      });
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                          Navigator.of(context).pushNamed(ChatScreen.id);
                        }
                        setState(() {
                          loadding = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                      addUser();
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                      }
                      _nameControler.clear();
                      _phoneControler.clear();
                      _emailControler.clear();
                      _passwordControler.clear();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
