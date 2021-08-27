// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
// File Imports

class TimePicker extends StatelessWidget {
  final Function onTimeChange;

  TimePicker({
    this.onTimeChange,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TimePickerSpinner(
          minutesInterval: 5,
          is24HourMode: false,
          isForce2Digits: true,
          normalTextStyle: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1C3857),
          ),
          highlightedTextStyle: TextStyle(
            fontSize: 25.0,
            color: Color(0xFF1C3857),
            fontWeight: FontWeight.bold,
          ),
          onTimeChange: onTimeChange,
        ),
        Container(
          height: 60.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white.withOpacity(0.6),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: Container(
            height: 60.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0.6),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
