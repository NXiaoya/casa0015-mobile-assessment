
import 'package:flutter/material.dart';
import 'package:pet_home/configuration.dart';
//import 'package:image_picker/image_picker.dart';
import 'dart:io';

class donation extends StatefulWidget {
  @override
  _donationPageState createState() => _donationPageState();
}

class _donationPageState extends State<donation> {

  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.amberAccent.shade100,
                    ),
                  ),
                  Expanded(
                      child: Container(
                        color: Colors.white,
                      )),
                ],
              )),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: 1,
                child: Image.asset(
                  'images/petcat1.png',
                  height: 400,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.ios_share_outlined),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 350,
              decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Add a cute picture:',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          size: 30,
                        ),
                        onPressed: () async {
                        },
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.amberAccent.shade400,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton.icon(
                              icon: Icon(
                                Icons.pets,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Help me find a home',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () async {},
                            ),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
