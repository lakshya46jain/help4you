// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports

class CartServiceTile extends StatelessWidget {
  final String customerUID;
  final String docId;
  final String professionalUID;
  final String serviceTitle;
  final String serviceDescription;
  final int servicePrice;

  CartServiceTile({
    @required this.customerUID,
    @required this.docId,
    @required this.professionalUID,
    @required this.serviceTitle,
    @required this.serviceDescription,
    @required this.servicePrice,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                serviceTitle,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                serviceDescription,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(
                height: 7.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price : $servicePrice",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      FluentIcons.delete_16_regular,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("H4Y Users Database")
                          .doc(customerUID)
                          .collection("Cart")
                          .doc(docId)
                          .delete();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
