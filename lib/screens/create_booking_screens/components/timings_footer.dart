// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/screens/create_booking_screens/summary_screen.dart';
import 'package:help4you/screens/create_booking_screens/timings_selection_screen.dart';

class TimingsFooter extends StatelessWidget {
  final DateTime mergedTime;
  final int slotBooked;
  final TimingsSelectionScreen widget;

  const TimingsFooter({
    Key key,
    @required this.mergedTime,
    @required this.slotBooked,
    @required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: SignatureButton(
              type: "Yellow",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SummaryScreen(
                      professionalUID: widget.professionalUID,
                      completeAddress: widget.completeAddress,
                      geoPointLocation: widget.geoPointLocation,
                      bookingTimings: mergedTime,
                      slotBooked: slotBooked,
                    ),
                  ),
                );
              },
              text: "Confirm Timings",
            ),
          ),
          const SizedBox(height: 50.0),
        ],
      ),
    );
  }
}
