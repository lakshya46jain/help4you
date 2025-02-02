// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/screens/create_booking_screens/components/summary_bar.dart';
import 'package:help4you/screens/create_booking_screens/components/summary_body.dart';

class SummaryScreen extends StatelessWidget {
  final String? professionalUID;
  final String? completeAddress;
  final GeoPoint? geoPointLocation;
  final DateTime? bookingTimings;
  final int? slotBooked;

  const SummaryScreen({
    Key? key,
    required this.professionalUID,
    required this.completeAddress,
    required this.geoPointLocation,
    required this.bookingTimings,
    required this.slotBooked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser?>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: const SignatureButton(type: "Back Button"),
        title: Text(
          "Booking Summary",
          style: GoogleFonts.balooPaaji2(
            fontSize: 25.0,
            color: const Color(0xFF1C3857),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SummaryBody(
        professionalUID: professionalUID,
        user: user,
        completeAddress: completeAddress,
        bookingTimings: bookingTimings,
      ),
      bottomNavigationBar: SummaryBar(
        professionalUID: professionalUID,
        completeAddress: completeAddress,
        geoPointLocation: geoPointLocation,
        bookingTimings: bookingTimings,
        slotBooked: slotBooked,
      ),
    );
  }
}
