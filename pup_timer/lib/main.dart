import 'package:flutter/material.dart';
import 'pomodoro_timer.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer',
      home: Scaffold(
        body: Center(
          child: Stack(
            children: [
              SleekCircularSlider(
                min: 0,
                max: 120,
                initialValue: 25,
                onChange: (double value) {},
              ),
              PomodoroTimer(),
            ],
          ),
        ),
      ),
    );
  }
}