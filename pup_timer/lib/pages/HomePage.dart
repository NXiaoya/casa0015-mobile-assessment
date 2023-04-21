import 'package:flutter/material.dart';
import 'package:pup_timer/pages/pomodoro_timer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PomodoroTimer()),
            );
          },
          child: const Text('Go to Pomodoro Timer'),
        ),
      ),
    );
  }
}