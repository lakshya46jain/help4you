// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string_generator/random_string_generator.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/services/onesignal_configuration.dart';
import 'package:help4you/screens/create_booking_screens/confirmation_screen.dart';

class SummaryBar extends StatelessWidget {
  final String professionalUID;
  final String completeAddress;
  final GeoPoint geoPointLocation;
  final DateTime bookingTimings;

  SummaryBar({
    @required this.professionalUID,
    @required this.completeAddress,
    @required this.geoPointLocation,
    @required this.bookingTimings,
  });

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20.0,
            color: Color(0xFFDADADA).withOpacity(0.5),
          ),
        ],
      ),
      child: StreamBuilder(
        stream: DatabaseService(uid: user.uid, professionalUID: professionalUID)
            .filteredCartServiceListData,
        builder: (context, snapshot) {
          double total = 0;
          List<CartServices> cartServices = snapshot.data;
          if (snapshot.connectionState == ConnectionState.active) {
            for (CartServices cartService in cartServices) {
              total += cartService.servicePrice * cartService.quantity;
            }
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "$total",
                  style: TextStyle(
                    fontSize: 28.0,
                    color: Color(0xFF1C3857),
                    fontFamily: "BalooPaaji",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  String bookingId = RandomStringGenerator(
                    fixedLength: 10,
                    hasAlpha: false,
                    hasDigits: true,
                    hasSymbols: false,
                  ).generate();
                  List<Map> bookedItems = [];
                  for (CartServices cartService in cartServices) {
                    bookedItems.add({
                      "Title": cartService.serviceTitle,
                      "Description": cartService.serviceDescription,
                      "Price": cartService.servicePrice,
                      "Quantity": cartService.quantity,
                    });
                    FirebaseFirestore.instance
                        .collection("H4Y Users Database")
                        .doc(user.uid)
                        .collection("Cart")
                        .doc(cartService.serviceId)
                        .delete();
                  }
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                      child: ConfirmationScreen(),
                      type: PageTransitionType.fade,
                    ),
                    (route) => false,
                  );
                  await DatabaseService(
                    uid: user.uid,
                    professionalUID: professionalUID,
                  ).createBooking(
                    bookingId,
                    completeAddress,
                    geoPointLocation,
                    bookingTimings,
                    "Booking Pending",
                    bookedItems,
                    total,
                  );
                  sendNotification(
                    professionalUID,
                    "You have a new booking!",
                    "Please check the details and update the user as soon as possible.",
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  height: MediaQuery.of(context).size.height * 0.13,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    color: Color(0xFF1C3857),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Checkout",
                        style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.white,
                          fontFamily: "BalooPaaji",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        CupertinoIcons.chevron_right,
                        color: Colors.white,
                        size: 28.0,
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
