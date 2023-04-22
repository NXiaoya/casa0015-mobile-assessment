
import 'package:pet_home/pages/screen/drawerScreen.dart';
import 'package:pet_home/pages/screen/HomeScreen.dart';
import 'package:pet_home/models/user.dart';
import 'package:pet_home/pages/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<currentUser>(context);
    print(user);

    if (user == null){
      return Authenticate();
    } else {
          return Scaffold(
          body: Stack(
            children: [
              drawerScreen(),
              HomeScreen()
            ],
          ),

        );
    }
  }
}
