import 'package:pet_home/models/userProfile.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {

  final userProfile userprofile;
  UserTile({ required this.userprofile });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
          ),
          title: Text(userprofile.location),
          subtitle: Text('My Contact ${userprofile.contact} '),
        ),
      ),
    );
  }
}