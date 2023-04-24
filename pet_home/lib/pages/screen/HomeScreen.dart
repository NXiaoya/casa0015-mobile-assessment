import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_home/pages/screen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_home/pages/screen/detailScreen.dart';
import 'package:pet_home/configuration.dart';
import 'package:pet_home/pages/screen/Profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_home/services/auth.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:pet_home/pages/screen/DescendantPage/adoption_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('donate_pet_info');

  late Stream<QuerySnapshot> _stream;

  // Declare isDrawerOpen as a member variable
  bool isDrawerOpen = false;
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    _stream = _reference.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    //offset to show the drawer

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Help me find a home',
        ),
        backgroundColor: Colors.amber,
        actions: [IconButton(
            icon: Icon(Icons.person),
          onPressed: (){
            Navigator.of(context)
                   .push(MaterialPageRoute(builder: (context) => Profile()));
          },
        )],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              child: DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('images/logo.png')),
                    color: Colors.amber,
                  ),
                  child:  BorderedText(
                  strokeWidth: 10.0,
                  strokeColor: Colors.orange,
                  child: Text(
                  'Pet Home',
                  style: TextStyle(color: Colors.white,
                  decoration: TextDecoration.none,
                  decorationColor: Colors.amber,fontSize: 40
                  ),
                  ),))
            ),
            Container(
              color: Colors.yellow.shade100,
              padding: EdgeInsets.only(top: 120, bottom: 130, left: 10),
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
                                            MaterialStateProperty.all(
                                                Colors.amber),
                                      ),
                                      icon: Icon(
                                        element['icon'],
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    element['direction']));
                                      },
                                      label: Text(
                                        element['title'],
                                        style: TextStyle(fontSize: 20),
                                      )),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 3,
                        height: 24,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton.icon(
                        icon: Icon(
                          Icons.person,
                          color: Colors.amber,
                          size: 24,
                        ),
                        label: Text(
                          'logout',
                          style: TextStyle(color: Colors.amber, fontSize: 24),
                        ),
                        onPressed: () async {
                          await _auth.signOut();
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            //search bar
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.yellow.shade50,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.search),
                    Text(
                      'Search pet to adopt',
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
            BorderedText(
              strokeWidth: 5.0,
              strokeColor: Colors.orange,
              child: Text(
                'Scroll and click to find your new family member',
                style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    decorationColor: Colors.amber,
                    fontSize: 15),
              ),
            ),
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
                            return ListTile(
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
