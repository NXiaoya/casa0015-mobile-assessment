
import 'package:flutter/material.dart';
import 'package:pet_home/services/database.dart';
import 'package:provider/provider.dart';
import 'package:pet_home/pages/screen/DescendantPage/settings_profile.dart';
import 'package:pet_home/configuration.dart';
import 'package:pet_home/models/user.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<currentUser>(context);
    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsProfile(),
        );
      });
    }
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Profile',style: TextStyle(color: Colors.orange,),),
                backgroundColor: Colors.amber.shade100,
                elevation: 1,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.orange,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Container(
                padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 200,
                        child: Image.asset('images/logo.png'),
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Edite and save to change your information",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      buildTextField("Full Name", userData!.name),
                      buildTextField("E-mail", userData.contact),
                      buildTextField("Location", userData.location),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _showSettingsPanel(),
                            icon: Icon(Icons.settings),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber.shade200,
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            label: Text(
                              "Change Profile",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.black),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        }
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}