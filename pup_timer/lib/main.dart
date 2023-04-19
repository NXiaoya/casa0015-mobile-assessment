import 'package:flutter/material.dart';


void main() {
  runApp( MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text("PupTimer")),
      body: const Center(
        child: Text("PupTimer",
          textDirection: TextDirection.ltr,
          style: TextStyle(
            color: Colors.orange,
            fontSize: 40)),
          ),
      ),
  ));
}
