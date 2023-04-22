import 'package:pet_home/pages/screen/HomeScreen.dart';
import 'package:pet_home/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade400,
        elevation: 0.0,
        title: Text('Sign in to Pet Home'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
         style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
          child: Text('sign in anon'),
          onPressed: () async {
            dynamic result = await _auth.signInAnon();
            if(result == null){
              print('error signing in');
            } else {
              print('signed in');
              print(result);
            }
          },
        ),
      ),
    );
  }
}