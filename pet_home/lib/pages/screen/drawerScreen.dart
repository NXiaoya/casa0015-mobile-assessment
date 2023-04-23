import 'package:flutter/material.dart';
import 'package:pet_home/services/auth.dart';
import 'package:pet_home/configuration.dart';
import 'package:pet_home/pages/screen/donation.dart';
import 'package:pet_home/pages/screen/favorites.dart';
import 'package:pet_home/pages/screen/Profile.dart';
import 'package:pet_home/pages/screen/HomeScreen.dart';

class drawerScreen extends StatefulWidget {
  @override
  _drawerScreenState createState() => _drawerScreenState();
}

class _drawerScreenState extends State<drawerScreen> {
  final AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Container(
            color: amber,
            padding: EdgeInsets.only(top: 220, bottom: 70, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: drawerItems
                      .map((element) => Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                ElevatedButton.icon(
                                    style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(Colors.amber),),
                                    icon: Icon(element['icon'],size: 30,),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  element['direction']));
                                    },
                                    label: Text(element['title'],style: TextStyle(fontSize: 20),)),
                              ],
                            ),
                          ))
                      .toList(),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 2,
                      height: 20,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.person,color: Colors.white,),
                      label: Text('logout',style: TextStyle(color: Colors.white),),
                      onPressed: () async {
                        setState(() => loading = true);
                        await _auth.signOut();
                      },
                    ),
                  ],
                )
              ],
            ),
          );
  }
}
