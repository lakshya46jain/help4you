// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/screens/project_details_screen/components/booked_items_list.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final String address;
  final String bookingId;
  final double totalPrice;
  final String occupation;
  final String thumbnailURL;
  final String bookingStatus;
  final Timestamp preferredTimings;
  final String paymentMethod;
  final List<CartServices> bookedItemsList;

  ProjectDetailsScreen({
    @required this.address,
    @required this.bookingId,
    @required this.totalPrice,
    @required this.occupation,
    @required this.thumbnailURL,
    @required this.bookingStatus,
    @required this.preferredTimings,
    @required this.paymentMethod,
    @required this.bookedItemsList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: SignatureButton(type: "Back Button"),
        title: Text(
          "Project Details",
          style: TextStyle(
            fontSize: 25.0,
            color: Color(0xFF1C3857),
            fontFamily: "BalooPaaji",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookedItemsList(
                bookedItemsList: bookedItemsList,
              ),
              SizedBox(height: 5.0),
              Divider(
                thickness: 1.0,
                color: Color(0xFFFEA700),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "$totalPrice",
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Text(
                "Order: #$bookingId",
                style: TextStyle(fontSize: 15.0),
              ),
              SizedBox(height: 10.0),
              Text(
                "Location: $address (${DateFormat("d MMMM yyyy").format(preferredTimings.toDate().toLocal())} ${DateFormat.jm().format(preferredTimings.toDate().toLocal())})",
                style: TextStyle(fontSize: 15.0),
              ),
              SizedBox(height: 10.0),
              Text(
                "Payment Method: $paymentMethod",
                style: TextStyle(fontSize: 15.0),
              ),
              SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
