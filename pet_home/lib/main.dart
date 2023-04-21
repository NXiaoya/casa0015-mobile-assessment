import 'package:flutter/material.dart';

import 'package:pet_home/pages/drawerScreen.dart';
import 'package:pet_home/pages/HomeScreen.dart';

void main(){
  runApp(MaterialApp(home: HomePage(),
    theme: ThemeData(
        fontFamily: 'Circular',
    ),
  ));
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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