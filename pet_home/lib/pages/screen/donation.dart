import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class donation extends StatefulWidget {
  const donation ({Key? key}) : super(key: key);

  @override
  State<donation> createState() => _donationState();
}

class _donationState extends State<donation> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerGender = TextEditingController();
  TextEditingController _controllerBreed = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();
  TextEditingController _controllerLocation = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  CollectionReference _reference =
  FirebaseFirestore.instance.collection('donate_pet_info');

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [Icon(Icons.pets),],
        title: Text('Pet Donation'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 4, color: Colors.amber),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 10))
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:  imageUrl.isNotEmpty ? NetworkImage(imageUrl) : AssetImage('images/logo.png') as ImageProvider,
                    )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 500,
                    decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: key,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Text('Help me find a home',style:TextStyle(fontSize:30,color: Colors.amber.shade800),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _controllerName,
                              decoration:
                              InputDecoration(hintText: 'Enter the pet name'),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the pet name';
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _controllerGender,
                              decoration:
                              InputDecoration(hintText: 'Enter the pet gender'),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter gender';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _controllerBreed,
                              decoration:
                              InputDecoration(hintText: 'Enter the pet breed'),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter breed';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _controllerAge,
                              decoration:
                              InputDecoration(hintText: 'Enter the pet age'),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter age';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _controllerLocation,
                              decoration:
                              InputDecoration(hintText: 'Enter the pet location(or your contact)'),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter contact info';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            Text('Upload a photo'),
                            IconButton(
                                onPressed: () async {
                                  /*
                              * Step 1. Pick/Capture an image   (image_picker)
                              * Step 2. Upload the image to Firebase storage
                              * Step 3. Get the URL of the uploaded image
                              * Step 4. Store the image URL inside the corresponding
                              *         document of the database.
                              * Step 5. Display the image on the list
                              *
                              * */

                                  /*Step 1:Pick image*/
                                  //Install image_picker
                                  //Import the corresponding library

                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? file =
                                  await imagePicker.pickImage(source: ImageSource.camera);
                                  print('${file?.path}');

                                  if (file == null) return;
                                  //Import dart:core
                                  String uniqueFileName =
                                  DateTime.now().millisecondsSinceEpoch.toString();

                                  /*Step 2: Upload to Firebase storage*/
                                  //Install firebase_storage
                                  //Import the library

                                  //Get a reference to storage root
                                  Reference referenceRoot = FirebaseStorage.instance.ref();
                                  Reference referenceDirImages =
                                  referenceRoot.child('images');

                                  //Create a reference for the image to be stored
                                  Reference referenceImageToUpload =
                                  referenceDirImages.child('name');

                                  //Handle errors/success
                                  try {
                                    //Store the file
                                    await referenceImageToUpload.putFile(File(file!.path));
                                    //Success: get the download URL
                                    imageUrl = await referenceImageToUpload.getDownloadURL();
                                  } catch (error) {
                                    //Some error occurred
                                  }
                                },
                                icon: Icon(Icons.camera_alt)),
                            ElevatedButton(
                              style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.amber.shade700)),
                                onPressed: () async {
                                  if (imageUrl.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(content: Text('Please upload an image')));

                                    return;
                                  }

                                  if (key.currentState!.validate()) {
                                    String itemName = _controllerName.text;
                                    String itemGender = _controllerGender.text;
                                    String itembreed = _controllerBreed.text;
                                    String itemAge = _controllerAge.text;
                                    String itemLocation = _controllerLocation.text;

                                    //Create a Map of data
                                    Map<String, String> dataToSend = {
                                      'name': itemName,
                                      'gender': itemGender,
                                      'breed': itembreed,
                                      'age':itemAge,
                                      'location':itemLocation,
                                      'image': imageUrl,
                                    };

                                    //Add a new item
                                    _reference.add(dataToSend);
                                  }
                                },
                                child: Text('Submit'))
                          ],
                        ),
                      ),
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
