// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/booking_model.dart';
import 'package:help4you/screens/bookings_screen/components/booking_tile.dart';

class BookingsScreenBody extends StatefulWidget {
  @override
  State<BookingsScreenBody> createState() => _BookingsScreenBodyState();
}

class _BookingsScreenBodyState extends State<BookingsScreenBody> {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).bookingsListData,
      builder: (context, snapshot) {
        List<Booking> bookingsList = snapshot.data;
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              top: 0.0,
              bottom: 100.0,
              right: 0.0,
              left: 0.0,
            ),
            itemCount: bookingsList.length,
            itemBuilder: (context, index) {
              return BookingTile(
                bookingId: bookingsList[index].bookingId,
                professionalUID: bookingsList[index].professionalUID,
                preferredTimings: bookingsList[index].preferredTimings,
                bookingStatus: bookingsList[index].bookingStatus,
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
