// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final String servicePrice;
  final int quantity;

  CartServiceTile({
    @required this.customerUID,
    @required this.docId,
    @required this.professionalUID,
    @required this.serviceTitle,
    @required this.serviceDescription,
    @required this.servicePrice,
    @required this.quantity,
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
                  Row(
                    children: [
                      IconButton(
                        icon: Container(
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.deepOrangeAccent,
                            ),
                          ),
                          child: Icon(
                            FluentIcons.subtract_20_regular,
                            color: Colors.deepOrangeAccent,
                            size: 16.0,
                          ),
                        ),
                        onPressed: () {},
                      ),
                      Text(
                        "$quantity",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: Container(
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.deepOrangeAccent,
                            ),
                          ),
                          child: Icon(
                            FluentIcons.add_20_regular,
                            color: Colors.deepOrangeAccent,
                            size: 16.0,
                          ),
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ],
              ),
              MaterialButton(
                padding: EdgeInsets.all(0.0),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("H4Y Users Database")
                      .doc(customerUID)
                      .collection("Cart")
                      .doc(docId)
                      .delete();
                  HapticFeedback.heavyImpact();
                },
                child: Container(
                  // Che
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.redAccent,
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / (1792 / 80),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Remove Service From Cart",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
