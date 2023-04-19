import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PomodoroTimer(),
    );
  }
}

class PomodoroTimer extends StatefulWidget {
  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  int _duration = 0; // Initial duration in minutes
  int _remainingSeconds = 0;
  bool _sliderEnabled=false;
  Timer? _timer;

  void _startTimer() {
    _remainingSeconds = _duration * 60;

    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
          _duration = (_remainingSeconds ~/ 60) + 1;
        } else {
          _timer!.cancel();
        }
        // Disable the slider if the timer is running
        _sliderEnabled = (_timer == null);
      });
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PupTimer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          SleekCircularSlider(
          min: 0,
          max: 120,
          initialValue: _duration.toDouble(),
          onChange: (value) {
            if (_timer == null) {
              setState(() {
                _duration = value.toInt();
              });
            }
          },
          innerWidget: (double value) {
            if (_timer != null) {
              return Center(
                child: Text(
                  _formatTime(_remainingSeconds),
                  style: TextStyle(fontSize: 24),
                ),
              );
            } else {
              return Center(
                child: Text(
                  _duration.toString(),
                  style: TextStyle(fontSize: 24),
                ),
              );
            }
          },
          // Disable the slider if the timer is running

        ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startTimer,
                  child: Text('Start'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _stopTimer,
                  child: Text('Stop'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
