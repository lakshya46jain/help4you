// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/constants/loading.dart';
import 'package:help4you/constants/back_button.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/secondary_screens/create_booking_screen/booking_summary_bar.dart';
import 'package:help4you/secondary_screens/create_booking_screen/booking_service_tile.dart';

class BookingSummaryScreen extends StatelessWidget {
  final String completeAddress;
  final GeoPoint geoPointLocation;
  final DateTime bookingTimings;

  BookingSummaryScreen({
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
      body: StreamBuilder(
        stream: DatabaseService(uid: user.uid).cartServiceListData,
        builder: (context, snapshot) {
          List<Help4YouCartServices> cartServices = snapshot.data;
          if (snapshot.hasData) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 20.0,
                    ),
                    child: Text.rich(
                      TextSpan(
                        text: "Selected Address:",
                        style: TextStyle(
                          color: Color(0xFF1C3857),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        children: [
                          TextSpan(
                            text: " $completeAddress",
                            style: TextStyle(
                              color: Color(0xFF95989A),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Text.rich(
                      TextSpan(
                        text: "Preferred Timing:",
                        style: TextStyle(
                          color: Color(0xFF1C3857),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        children: [
                          TextSpan(
                            text:
                                " ${DateFormat.jm().format(bookingTimings)} on ${DateFormat("d MMMM yyyy").format(bookingTimings)}",
                            style: TextStyle(
                              color: Color(0xFF95989A),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      thickness: 3.0,
                      color: Color(0xFF95989A).withOpacity(0.2),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Ordered Services",
                      style: TextStyle(
                        height: 1.0,
                        color: Color(0xFF1C3857),
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: cartServices.length,
                    padding: EdgeInsets.all(0.0),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BookingServiceTile(
                        serviceId: cartServices[index].serviceId,
                        professionalId: cartServices[index].professionalId,
                        serviceTitle: cartServices[index].serviceTitle,
                        serviceDescription:
                            cartServices[index].serviceDescription,
                        servicePrice: cartServices[index].servicePrice,
                        quantity: cartServices[index].quantity,
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return DoubleBounceLoading();
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
