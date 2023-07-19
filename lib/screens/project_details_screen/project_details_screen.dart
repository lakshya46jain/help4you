// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/screens/project_details_screen/components/cancel_button.dart';
import 'package:help4you/screens/project_details_screen/components/booked_items_list.dart';
import 'package:help4you/screens/project_details_screen/components/make_payment_button.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final String? uid;
  final String? address;
  final String? bookingId;
  final double? totalPrice;
  final String? bookingStatus;
  final Timestamp? preferredTimings;
  final String? paymentMethod;
  final String? otp;
  final List<CartServices>? bookedItemsList;

  const ProjectDetailsScreen({
    Key? key,
    required this.uid,
    required this.address,
    required this.bookingId,
    required this.totalPrice,
    required this.bookingStatus,
    required this.preferredTimings,
    required this.paymentMethod,
    required this.otp,
    required this.bookedItemsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget otpRow(int index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.5),
        child: Container(
          width: 40.0,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(222, 231, 240, .57),
            border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
          ),
          child: Center(
            child: Text(
              otp![index],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(30, 60, 87, 1),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: const SignatureButton(type: "Back Button"),
        title: Text(
          "Project Details",
          style: GoogleFonts.balooPaaji2(
            fontSize: 25.0,
            color: const Color(0xFF1C3857),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              body: Column(
                children: [
                  const SizedBox(height: 5.0),
                  const Text(
                    "COMPLETION CODE",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      otpRow(0),
                      otpRow(1),
                      otpRow(2),
                      otpRow(3),
                      otpRow(4),
                      otpRow(5),
                    ],
                  ),
                  const SizedBox(height: 25.0),
                ],
              ),
            ).show(),
            icon: const Icon(
              CupertinoIcons.barcode,
              size: 25.0,
              color: Color(0xFFFEA700),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookedItemsList(
                bookedItemsList: bookedItemsList,
              ),
              const SizedBox(height: 5.0),
              const Divider(
                thickness: 1.0,
                color: Color(0xFFFEA700),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total:",
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "$totalPrice",
                    style: const TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Text(
                "Order: #$bookingId",
                style: const TextStyle(fontSize: 15.0),
              ),
              const SizedBox(height: 10.0),
              Text(
                "Location: $address (${DateFormat("d MMMM yyyy").format(preferredTimings!.toDate().toLocal())} ${DateFormat.jm().format(preferredTimings!.toDate().toLocal())})",
                style: const TextStyle(fontSize: 15.0),
              ),
              const SizedBox(height: 10.0),
              Text(
                "Payment Method: $paymentMethod",
                style: const TextStyle(fontSize: 15.0),
              ),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
      floatingActionButton:
          (bookingStatus == "Booking Pending" || bookingStatus == "Accepted")
              ? CancelButton(uid: uid, bookingId: bookingId)
              : (bookingStatus == "Job Completed" &&
                      paymentMethod == "Payment Incomplete")
                  ? MakePaymentButton(uid: uid, bookingId: bookingId)
                  : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
