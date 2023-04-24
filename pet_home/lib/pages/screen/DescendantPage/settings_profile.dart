//import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_home/configuration.dart';
import 'package:flutter/material.dart';
import 'package:pet_home/models/user.dart';
import 'package:pet_home/models/userProfile.dart';
import 'package:pet_home/services/database.dart';
import 'package:provider/provider.dart';

class SettingsProfile extends StatefulWidget {
  @override
  _SettingsProfileState createState() => _SettingsProfileState();
}

class _SettingsProfileState extends State<SettingsProfile> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String? _currentUid;
  String? _currentName;
  String? _currentContact;
  String? _currentLocation;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<currentUser>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your profile page.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Please enter your new user name',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Location',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: userData.location,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter your location' : null,
                    onChanged: (val) => setState(() => _currentLocation = val),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Contact',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  TextFormField(
                    initialValue: userData.contact,
                    decoration: textInputDecoration,
                    validator: (val) =>
                    val!.isEmpty ? 'Please enter your contact' : null,
                    onChanged: (val) => setState(() => _currentContact = val),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber.shade700)),
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                            _currentName ?? userData.name,
                            _currentLocation ?? userData.location,
                            _currentContact ?? userData.contact,
                          );
                          Navigator.pop(context);
                        }
                      })
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
