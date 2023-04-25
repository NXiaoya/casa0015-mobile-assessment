import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_home/configuration.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:pet_home/pages/screen/favorites.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdoptionDetails extends StatelessWidget {
  AdoptionDetails(this.itemId, {Key? key}) : super(key: key) {
    _reference =
        FirebaseFirestore.instance.collection('donate_pet_info').doc(itemId);
    _futureData = _reference.get();
  }

  String itemId;
  late DocumentReference _reference;

  //_reference.get()  --> returns Future<DocumentSnapshot>
  //_reference.snapshots() --> Stream<DocumentSnapshot>
  late Future<DocumentSnapshot> _futureData;
  late Map data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My detail',
        ),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.yellow.shade100,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: FutureBuilder<DocumentSnapshot>(
                    future: _futureData,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                            child:
                                Text('Some error occurred ${snapshot.error}'));
                      }

                      if (snapshot.hasData) {
                        //Get the data
                        DocumentSnapshot documentSnapshot = snapshot.data;
                        data = documentSnapshot.data() as Map;

                        //display the data
                        return Container(
                          color: Colors.yellow.shade100,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Hero(
                                    tag: 1,
                                    child: Image.network(
                                      data['image'],
                                      height: 300,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.amber.shade100,
                                      borderRadius: BorderRadius.all(Radius.circular(30))),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      BorderedText(
                                        strokeWidth: 5.0,
                                        strokeColor: Colors.orange,
                                        child: Text(
                                          'Hi',
                                          style: TextStyle(
                                              color: Colors.white,
                                              decoration: TextDecoration.none,
                                              decorationColor: Colors.amber,
                                              fontSize: 20),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      BorderedText(
                                        strokeWidth: 5.0,
                                        strokeColor: Colors.orange,
                                        child: Text(
                                          'My name is ${data['name']}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              decoration: TextDecoration.none,
                                              decorationColor: Colors.amber,
                                              fontSize: 20),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      BorderedText(
                                        strokeWidth: 5.0,
                                        strokeColor: Colors.orange,
                                        child: Text(
                                          'I am a ${data['breed']}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              decoration: TextDecoration.none,
                                              decorationColor: Colors.amber,
                                              fontSize: 20),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      BorderedText(
                                        strokeWidth: 5.0,
                                        strokeColor: Colors.orange,
                                        child: Text(
                                          'I am ${data['age']}-years-old ${data['gender']}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              decoration: TextDecoration.none,
                                              decorationColor: Colors.amber,
                                              fontSize: 20),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      BorderedText(
                                        strokeWidth: 5.0,
                                        strokeColor: Colors.orange,
                                        child: Text(
                                          'If you want to adopt me: ${data['location']}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              decoration: TextDecoration.none,
                                              decorationColor: Colors.amber,
                                              fontSize: 20),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton.icon(
                                          icon: Icon(Icons.favorite),
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                                          label: Text('Adopt Me',
                                                   style: TextStyle(
                                                       color: Colors.white,
                                                        fontSize: 24)),
                                        onPressed: () async {
                                          final user = FirebaseAuth.instance.currentUser;
                                          final userId = user?.uid;

                                          await FirebaseFirestore.instance
                                              .collection('user_favorites')
                                              .doc(userId)
                                              .collection('pet_information')
                                              .doc(itemId)
                                              .set({
                                            'name': data['name'],
                                            'gender': data['gender'],
                                            'breed': data['breed'],
                                            'age': data['age'],
                                            'location': data['location'],
                                            'image': data['image'],
                                          });

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => favorites(),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
