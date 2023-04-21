import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_home/configuration.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0),
      duration: Duration(milliseconds: 250),
      color: Colors.yellow.shade100,
      child: Column(
        children: [
          SizedBox(height: 60,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isDrawerOpen?IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: (){
                          setState(() {
                            xOffset=0;
                            yOffset=0;
                            scaleFactor=1;
                            isDrawerOpen=false;
                          });
                        },

                      ): IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            setState(() {
                              xOffset = 230;
                              yOffset = 150;
                              scaleFactor = 0.6;
                              isDrawerOpen=true;
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
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.yellow.shade50,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.search),
                Text('Search pet to adopt'),
                Icon(Icons.settings)
              ],
             )
          ),
        ],
      ),
    );
  }
}