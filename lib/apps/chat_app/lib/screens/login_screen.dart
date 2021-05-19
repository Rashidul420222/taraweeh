import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../components/reuseable_button.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _emailControler = TextEditingController();
  final _passwordControler = TextEditingController();
  String email, password;
  bool loadding = false, _obscureText = true;

  @override
  void dispose() {
    _emailControler.dispose();
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
                  TextFormField(
                    controller: _emailControler,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => !value.contains('@')
                        ? 'Please enter a valid email addres'
                        : null,
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
                    title: 'Log In',
                    color: Colors.black,
                    onPressed: () async {
                      setState(() {
                        loadding = true;
                      });
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          Navigator.of(context).pushNamed(ChatScreen.id);
                        }
                        setState(() {
                          loadding = false;
                        });
                      } catch (e) {
                        print(e);
                      }

                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                      }

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
