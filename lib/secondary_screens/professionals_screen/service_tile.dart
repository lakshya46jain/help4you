// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/constants/custom_snackbar.dart';

class ServiceTiles extends StatefulWidget {
  final String serviceId;
  final String professionalId;
  final String serviceTitle;
  final String serviceDescription;
  final double servicePrice;

  ServiceTiles({
    @required this.serviceId,
    @required this.professionalId,
    @required this.serviceTitle,
    @required this.serviceDescription,
    @required this.servicePrice,
  });

  @override
  _ServiceTilesState createState() => _ServiceTilesState();
}

class _ServiceTilesState extends State<ServiceTiles> {
  // Text Field Variables
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
          border: Border.all(
            color: Color(0xFF95989A),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.serviceTitle,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.serviceDescription,
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xFF95989A),
              ),
            ),
            SizedBox(
              height: 7.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Price : ${widget.servicePrice}",
                  style: TextStyle(
                    fontSize: 14.0,
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
                      onPressed: () {
                        if (quantity != 1) {
                          setState(
                            () {
                              quantity--;
                            },
                          );
                        }
                      },
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
                      onPressed: () {
                        setState(
                          () {
                            quantity++;
                          },
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            MaterialButton(
              padding: EdgeInsets.all(0.0),
              onPressed: () async {
                DocumentSnapshot ds = await FirebaseFirestore.instance
                    .collection("H4Y Users Database")
                    .doc(user.uid)
                    .collection("Cart")
                    .doc(widget.serviceId)
                    .get();
                if (ds.exists) {
                  showCustomSnackBar(
                    context,
                    FluentIcons.checkmark_circle_24_regular,
                    Colors.orange,
                    "Warning!",
                    "Service has already been added to your cart",
                  );
                } else {
                  await DatabaseService(uid: user.uid).addToCart(
                    widget.serviceId,
                    widget.professionalId,
                    widget.serviceTitle,
                    widget.serviceDescription,
                    widget.servicePrice,
                    quantity,
                  );
                  HapticFeedback.heavyImpact();
                  showCustomSnackBar(
                    context,
                    FluentIcons.checkmark_circle_24_regular,
                    Colors.green,
                    "Congratulations!",
                    "Service was added to your cart",
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.deepOrangeAccent,
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
                      "Add to Cart",
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
    );
  }
}
