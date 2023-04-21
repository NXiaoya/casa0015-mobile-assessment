import 'package:flutter/material.dart';
import 'package:pet_home/configuration.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  double xOffset =0;
  double yOffset =0;
  double scaleFactor =1;


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),

      duration: Duration(milliseconds: 250),
      color: Colors.white,
      child: Column(
        children:[
          SizedBox(height: 60,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: Icon(Icons.menu), onPressed:(){
                setState(() {
                  xOffset =230;
                  yOffset=150;
                  scaleFactor=0.6;
                });
              }),
              Column(
                children: [
                  Text('Location'),
                  Row(
                    children: [
                      Icon(Icons.location_on,color: amber,),
                      Text('London'),
                    ],
                  )
                ],
              ),
              CircleAvatar()
            ],
          )
        ]
      ),
    );

  }
}