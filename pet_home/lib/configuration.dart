//This is the configuration file that contains some general settings

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pet_home/pages/screen/donation.dart';
import 'package:pet_home/pages/screen/favorites.dart';
import 'package:pet_home/pages/screen/Profile.dart';
import 'package:pet_home/pages/screen/HomeScreen.dart';
//import 'package:pet_home/pages/screen/pet_list.dart';

Color amber = Colors.amber;

//box shadow setting
List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey.shade300, blurRadius: 30, offset: Offset(0, 10))
];

List<Map> categories = [
  {'name': 'Cats', 'iconPath': 'images/cat.png'},
  {'name': 'Dogs', 'iconPath': 'images/dog.png'},
];

//drawer
List<Map> drawerItems=[
  {
    'icon': Icons.add_box_outlined,
    'title' : 'Add to adoption list',
    'direction': donation(),
  },
  {
    'icon': Icons.favorite,
    'title' : 'Favorites',
    'direction': favorites(),
  },
  {
    'icon': Icons.person,
    'title' : 'Profile',
    'direction': Profile(),
  },
  // {
  //   'icon': Icons.list_alt,
  //   'title': 'Pet List',
  //   'direction': ItemList(),
  // }
];
//Input decoration
const textInputDecoration = InputDecoration(
  fillColor: Colors.yellow,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.amberAccent, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.amberAccent, width: 2.0),
  ),
);

//loading page
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent[100],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.amberAccent,
          size: 50.0,
        ),
      ),
    );
  }
}