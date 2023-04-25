import 'package:pet_home/pages/screen/HomeScreen.dart';
import 'package:pet_home/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_home/configuration.dart';
import 'package:bordered_text/bordered_text.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
      backgroundColor: Colors.amber.shade100,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade400,
        elevation: 0.0,
        title: Text('Sign in to Pet Home'),
        actions: <Widget>[
          ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.amber.shade700)),
              icon: Icon(Icons.person),
              label: Text('Register'),
              onPressed: () {
                widget.toggleView();
              })
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('images/icon.png'),
                    backgroundColor: Colors.amber,
                  ),
                  SizedBox(
                      child: DrawerHeader(
                          child:  BorderedText(
                            strokeWidth: 10.0,
                            strokeColor: Colors.orange,
                            child: Text(
                              'Pet Home',
                              style: TextStyle(color: Colors.white,fontSize: 40),
                            ),))
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'email'),
                    validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),//enter email
                  SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(hintText: 'password'),
                    validator: (val) =>
                        val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),//enter password
                  SizedBox(height: 20.0),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber)),
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(()=>loading=true);
                          dynamic result = await _auth.signInWithEmailAndPassword(
                              email, password);
                          if (result == null) {
                            loading = false;
                            setState(() {
                              error = 'Please enter a valid email or password';
                            });
                          }
                        }
                      }),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
