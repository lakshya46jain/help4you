// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/services/database.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/constants/custom_snackbar.dart';

class BookingServiceTile extends StatelessWidget {
  final String serviceId;
  final String professionalId;
  final String serviceTitle;
  final String serviceDescription;
  final double servicePrice;
  final int quantity;

  BookingServiceTile({
    this.serviceId,
    @required this.professionalId,
    @required this.serviceTitle,
    @required this.serviceDescription,
    @required this.servicePrice,
    @required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 20.0,
      ),
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        serviceTitle,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF1C3857),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "$servicePrice",
                        style: TextStyle(
                          color: Color(0xFF1C3857),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Container(
                    height: 30.0,
                    width: 80.0,
                    padding: EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color(0xFF95989A).withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.5),
                              color: Colors.white,
                            ),
                            child: Icon(
                              FluentIcons.subtract_16_filled,
                              color: Color(0xFFFEA700),
                              size: 18.0,
                            ),
                          ),
                          onTap: () async {
                            if (quantity - 1 == 0) {
                              await FirebaseFirestore.instance
                                  .collection("H4Y Users Database")
                                  .doc(user.uid)
                                  .collection("Cart")
                                  .doc(serviceId)
                                  .delete();
                              showCustomSnackBar(
                                context,
                                FluentIcons.warning_24_regular,
                                Colors.orange,
                                "Warning!",
                                "Service has been removed from your cart.",
                              );
                            } else {
                              await DatabaseService(uid: user.uid)
                                  .updateQuantity(
                                serviceId,
                                quantity - 1,
                              );
                              showCustomSnackBar(
                                context,
                                FluentIcons.warning_24_regular,
                                Colors.orange,
                                "Warning!",
                                "Service has been removed from your cart.",
                              );
                            }
                          },
                        ),
                        Text(
                          "$quantity",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xFF1C3857),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.5),
                              color: Colors.white,
                            ),
                            child: Icon(
                              FluentIcons.add_20_filled,
                              color: Color(0xFFFEA700),
                              size: 18.0,
                            ),
                          ),
                          onTap: () async {
                            if (quantity != 25) {
                              await DatabaseService(uid: user.uid)
                                  .updateQuantity(
                                serviceId,
                                quantity + 1,
                              );
                              showCustomSnackBar(
                                context,
                                FluentIcons.checkmark_circle_24_regular,
                                Colors.green,
                                "Congratulations!",
                                "Service was added to your cart",
                              );
                            } else {
                              showCustomSnackBar(
                                context,
                                FluentIcons.warning_24_regular,
                                Colors.orange,
                                "Warning!",
                                "You have recieved maximum limit for this service.",
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
