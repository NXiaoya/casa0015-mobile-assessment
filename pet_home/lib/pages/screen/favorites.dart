import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_home/pages/screen/DescendantPage/adoption_detail.dart';
import 'package:pet_home/pages/screen/HomeScreen.dart';
import 'package:pet_home/pages/screen/Profile.dart';
import 'package:pet_home/pages/screen/detailScreen.dart';
import 'package:pet_home/services/auth.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

class favorites extends StatefulWidget {
  const favorites({Key? key}) : super(key: key);

  @override
  _favoritesState createState() => _favoritesState();
}

class _favoritesState extends State<favorites> {
  late CollectionReference _reference;
  late Stream<QuerySnapshot> _stream;

  // Declare isDrawerOpen as a member variable
  bool isDrawerOpen = false;
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    _reference = FirebaseFirestore.instance
        .collection('user_favorites')
        .doc(userId)
        .collection('pet_information');
    _stream = _reference.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    _reference = FirebaseFirestore.instance
        .collection('user_favorites')
        .doc(userId)
        .collection('pet_information');
    _stream = _reference.snapshots();

    //offset to show the drawer

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My interests',
        ),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Profile()));
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            BorderedText(
              strokeWidth: 5.0,
              strokeColor: Colors.orange,
              child: Text(
                'Contact the owner or the information provider',
                style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    decorationColor: Colors.amber,
                    fontSize: 15),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    //Check error
                    if (snapshot.hasError) {
                      return Center(
                          child: Text('Some error occurred ${snapshot.error}'));
                    }
                    //Check if data arrived
                    if (snapshot.hasData) {
                      //get the data
                      QuerySnapshot querySnapshot = snapshot.data;
                      List<QueryDocumentSnapshot> documents =
                          querySnapshot.docs;

                      List<Map> items = documents.map((e) => {
                        'id': e.id,
                        'name': e['name'],
                        'gender': e['gender'],
                        'breed': e['breed'],
                        'age': e['age'],
                        'location': e['location'],
                        'image':e['image']
                      }).toList();

                      //Display the list
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            //Get the item at this index
                            Map thisItem = items[index];
                            //REturn the widget for the list items
                            return SizedBox(
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                                title: Text('${thisItem['name']}'),
                                subtitle: Text(
                                  'Breed: ${thisItem['breed']}',
                                ),
                                leading: Container(
                                  height: 100,
                                  width: 80,
                                  child: Image.network('${thisItem['image']}'),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AdoptionDetails(thisItem['id'])));
                                },
                              ),
                            );
                          });
                    }

                    //Show loader
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ); //Display a list // Add a FutureBuilder]

  }
}
