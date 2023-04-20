import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

void main() => runApp(PomodoroTimer());

class PomodoroTimer extends StatefulWidget {
  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  int _sliderValue = 0;
  int _remainingTime = 0;
  Timer? _timer;
  final List<String> _timerTypes = ['study', 'work', 'exercise', 'social', 'relax'];
  String _selectedTimerType = 'study';

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
      title: 'PupTimer',
      home: Scaffold(
        appBar: AppBar(
          title: Text('PupTimer'),
        ),
        body:
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SleekCircularSlider(
                min: 0,
                max: 120,
                initialValue: _sliderValue.toDouble(),
                appearance: CircularSliderAppearance(
                  customColors: CustomSliderColors(trackColor: Colors.amberAccent,progressBarColors:
                  [Colors.orange, Colors.yellowAccent],shadowColor:Colors.limeAccent,shadowMaxOpacity: 20.0),
                  infoProperties: InfoProperties(topLabelText: 'Running..'),
                ),
              onChangeEnd: (value) {
                  if (_timer == null) {
                    setState(() {
                      _sliderValue = value.toInt();
                      _remainingTime = _sliderValue * 60;
                    });
                  }
                },
                innerWidget: (double value) {
                  return Center(
                    child: Text(
                      _displayTime,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 32.0),
              DropdownButton<String>(
                value: _selectedTimerType,
                onChanged: (value) {
                  setState(() {
                    _selectedTimerType = value!;
                  });
                },
                items: _timerTypes.map((timerType) {
                  return DropdownMenuItem<String>(
                    value: timerType,
                    child: Text(timerType),
                  );
                }).toList(),
              ),
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
