import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void main() => runApp(PomodoroTimer());

class PomodoroTimer extends StatefulWidget {
  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  int _sliderValue = 25;
  int _remainingTime = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = _sliderValue * 60;
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _cancelTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
      setState(() {
        _remainingTime = _sliderValue * 60;
      });
    }
  }

  String get _displayTime {
    int minutes = _remainingTime ~/ 60;
    int seconds = _remainingTime % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pomodoro Timer'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SleekCircularSlider(
                min: 0,
                max: 120,
                initialValue: _sliderValue.toDouble(),
                onChangeEnd: (value) {
                  if (_timer == null) {
                    setState(() {
                      _sliderValue = value.toInt();
                      _remainingTime = _sliderValue * 60;
                    });
                  }
                },
              ),
              SizedBox(height: 32.0),
              Text(
                _displayTime,
                style: TextStyle(fontSize: 64.0),
              ),
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _timer == null ? _startTimer : null,
                    child: Text('Start'),
                  ),
                  ElevatedButton(
                    onPressed: _timer != null ? _cancelTimer : null,
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
