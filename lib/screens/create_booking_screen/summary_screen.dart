// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/constants/back_button.dart';
import 'package:help4you/screens/create_booking_screen/components/summary_bar.dart';
import 'package:help4you/screens/create_booking_screen/components/summary_body.dart';

class SummaryScreen extends StatelessWidget {
  final String completeAddress;
  final GeoPoint geoPointLocation;
  final DateTime bookingTimings;

  SummaryScreen({
    @required this.completeAddress,
    @required this.geoPointLocation,
    @required this.bookingTimings,
  });

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: CustomBackButton(),
        title: Text(
          "Booking Summary",
          style: TextStyle(
            fontSize: 25.0,
            color: Color(0xFF1C3857),
            fontFamily: "BalooPaaji",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SummaryBody(
        user: user,
        completeAddress: completeAddress,
        bookingTimings: bookingTimings,
      ),
      bottomNavigationBar: SummaryBar(
        professionalUID: "",
        completeAddress: completeAddress,
        geoPointLocation: geoPointLocation,
        bookingTimings: bookingTimings,
      ),
    );
  }
}
