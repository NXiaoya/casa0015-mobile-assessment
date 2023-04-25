import 'package:flutter/material.dart';
import 'package:pet_home/pages/wrapper.dart';
import 'package:bordered_text/bordered_text.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var d = Duration(seconds: 2);
    // delayed 3 seconds to next page
    Future.delayed(d, () {
      // to next page and close this page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Wrapper();
          },
        ),
            (route) => false,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background1.jpg'),
              fit: BoxFit.fill
          ),
        ),
        child: Center(
          child: Container(
              height: 500,
              child: Column(
                children: [
                  BorderedText(
                    strokeWidth: 5.0,
                    strokeColor: Colors.amber,
                    child: Text(
                      'Pet Home',
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          decorationColor: Colors.amber,
                          fontSize: 50),
                    ),
                  ),
                  BorderedText(
                    strokeWidth: 5.0,
                    strokeColor: Colors.amber,
                    child: Text(
                      'Love and Rescue',
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          decorationColor: Colors.amber,
                          fontSize: 30),
                    ),
                  ),
                  Image(image: AssetImage('images/header.png'),),
                ],
              )),

        ),
      ),
    );
  }
}