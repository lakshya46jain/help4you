// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string_generator/random_string_generator.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/screens/create_booking_screens/confirmation_screen.dart';

class SummaryBar extends StatelessWidget {
  final String? professionalUID;
  final String? completeAddress;
  final GeoPoint? geoPointLocation;
  final DateTime? bookingTimings;
  final int? slotBooked;

  const SummaryBar({
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

    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20.0,
            color: const Color(0xFFDADADA).withOpacity(0.5),
          ),
        ],
      ),
      child: StreamBuilder(
        stream:
            DatabaseService(uid: user!.uid, professionalUID: professionalUID)
                .filteredCartServiceListData,
        builder: (context, snapshot) {
          double total = 0;
          List<CartServices>? cartServices =
              snapshot.data as List<CartServices>?;
          if (snapshot.connectionState == ConnectionState.active) {
            for (CartServices cartService in cartServices!) {
              total += cartService.servicePrice! * cartService.quantity!;
            }
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "$total",
                  style: GoogleFonts.balooPaaji2(
                    fontSize: 28.0,
                    color: const Color(0xFF1C3857),
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
                  for (CartServices cartService in cartServices!) {
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
                      child: const ConfirmationScreen(),
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
                    slotBooked,
                    "Booking Pending",
                    bookedItems,
                    total,
                  );
                  // Send Notification: Please check the details and update the user as soon as possible.
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  height: MediaQuery.of(context).size.height * 0.13,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: const BoxDecoration(
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
                        style: GoogleFonts.balooPaaji2(
                          fontSize: 28.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(
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
