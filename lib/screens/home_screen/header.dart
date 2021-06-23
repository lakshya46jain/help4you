// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/screens/cart_screen/cart.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get User UID
    final user = Provider.of<Help4YouUser>(context);

    // Key Variables
    var message = '';
    var currentTime = int.parse(
      DateFormat('kk').format(
        DateTime.now(),
      ),
    );

    // Message Updating
    if (currentTime <= 12) {
      message = 'Good Morning ⛅️';
    } else if ((currentTime > 12) && (currentTime <= 16)) {
      message = 'Good Afternoon 🌤';
    } else if ((currentTime > 16) && (currentTime < 20)) {
      message = 'Good Evening 🌇';
    } else {
      message = 'Good Night 🌙';
    }

    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              UserDataCustomer userData = snapshot.data;
              return Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      height: 60,
                      width: 60,
                      imageUrl: userData.profilePicture,
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey,
                          fontFamily: "BalooPaaji",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        userData.fullName,
                        style: TextStyle(
                          height: 1.0,
                          fontSize: 23.0,
                          color: Colors.black,
                          fontFamily: "BalooPaaji",
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("H4Y Users Database")
                .doc(user.uid)
                .collection("Cart")
                .snapshots(),
            builder: (context, snapshot) {
              int totalItems = 0;
              if (snapshot.connectionState == ConnectionState.active) {
                List documents = snapshot.data.docs;
                totalItems = documents.length;
              }
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "$totalItems" ?? "0",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "BalooPaaji",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
