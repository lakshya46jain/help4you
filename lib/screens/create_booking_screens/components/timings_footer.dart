// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:intl/intl.dart';
// File Imports
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/screens/create_booking_screens/summary_screen.dart';
import 'package:help4you/screens/create_booking_screens/timings_selection_screen.dart';

class TimingsFooter extends StatelessWidget {
  final DateTime time;
  final DateTime focusedDay;
  final TimingsSelectionScreen widget;

  TimingsFooter({
    @required this.time,
    @required this.focusedDay,
    @required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              text: "${DateFormat.jm().format(time)}",
              children: [
                TextSpan(
                  text: "\non ${DateFormat("d MMMM yyyy").format(focusedDay)}",
                ),
              ],
            ),
            style: TextStyle(
              fontSize: 20.0,
              color: Color(0xFF1C3857),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: SignatureButton(
              type: "Yellow",
              onTap: () {
                final DateTime mergedTime = DateTime(
                  focusedDay.year,
                  focusedDay.month,
                  focusedDay.day,
                  time.hour,
                  time.minute,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SummaryScreen(
                      professionalUID: widget.professionalUID,
                      completeAddress: widget.completeAddress,
                      geoPointLocation: widget.geoPointLocation,
                      bookingTimings: mergedTime,
                    ),
                  ),
                );
              },
              text: "Confirm Timings",
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }
}
