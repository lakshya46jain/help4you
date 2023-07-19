// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/services/database.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/constants/custom_snackbar.dart';

class BookingServiceTile extends StatelessWidget {
  final String? serviceId;
  final String? professionalId;
  final String? serviceTitle;
  final String? serviceDescription;
  final double? servicePrice;
  final int? quantity;

  const BookingServiceTile({
    Key? key,
    this.serviceId,
    required this.professionalId,
    required this.serviceTitle,
    required this.serviceDescription,
    required this.servicePrice,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser?>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 20.0,
      ),
      child: SizedBox(
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
                        serviceTitle!,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF1C3857),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        "$servicePrice",
                        style: const TextStyle(
                          color: Color(0xFF1C3857),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                    height: 30.0,
                    width: 80.0,
                    padding: const EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: const Color(0xFF95989A).withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.5),
                              color: Colors.white,
                            ),
                            child: const Icon(
                              CupertinoIcons.minus,
                              color: Color(0xFFFEA700),
                              size: 18.0,
                            ),
                          ),
                          onTap: () async {
                            if (quantity! - 1 == 0) {
                              await FirebaseFirestore.instance
                                  .collection("H4Y Users Database")
                                  .doc(user!.uid)
                                  .collection("Cart")
                                  .doc(serviceId)
                                  .delete()
                                  .then(
                                    (value) => showCustomSnackBar(
                                      context,
                                      CupertinoIcons.exclamationmark_triangle,
                                      Colors.orange,
                                      "Warning!",
                                      "Service has been removed from your cart.",
                                    ),
                                  );
                            } else {
                              await DatabaseService(uid: user!.uid)
                                  .updateQuantity(
                                    serviceId,
                                    quantity! - 1,
                                  )
                                  .then(
                                    (value) => showCustomSnackBar(
                                      context,
                                      CupertinoIcons.exclamationmark_triangle,
                                      Colors.orange,
                                      "Warning!",
                                      "Service has been removed from your cart.",
                                    ),
                                  );
                            }
                          },
                        ),
                        Text(
                          "$quantity",
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Color(0xFF1C3857),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.5),
                              color: Colors.white,
                            ),
                            child: const Icon(
                              CupertinoIcons.add,
                              color: Color(0xFFFEA700),
                              size: 18.0,
                            ),
                          ),
                          onTap: () async {
                            if (quantity != 25) {
                              await DatabaseService(uid: user!.uid)
                                  .updateQuantity(
                                    serviceId,
                                    quantity! + 1,
                                  )
                                  .then(
                                    (value) => showCustomSnackBar(
                                      context,
                                      CupertinoIcons.checkmark_alt_circle,
                                      Colors.green,
                                      "Congratulations!",
                                      "Service was added to your cart",
                                    ),
                                  );
                            } else {
                              showCustomSnackBar(
                                context,
                                CupertinoIcons.exclamationmark_triangle,
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
