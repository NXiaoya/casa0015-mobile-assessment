import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_home/pages/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pet_home/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:pet_home/models/user.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<currentUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.amberAccent.shade100,
        ),
        home: Wrapper(),
      ),
    );
  }
}