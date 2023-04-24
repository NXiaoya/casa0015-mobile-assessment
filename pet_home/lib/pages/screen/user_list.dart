import 'package:pet_home/models/userProfile.dart';
import 'package:pet_home/pages/screen/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {

    final profiles = Provider.of<List<userProfile>>(context);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        return UserTile(userprofile: profiles[index]);
      },
    );
  }
}