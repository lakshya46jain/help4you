// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/screens/cart_screen/cart_service_tile.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get User UID
    final user = Provider.of<Help4YouUser>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("H4Y Users Database")
            .doc(user.uid)
            .collection("Cart")
            .snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
              return CartServiceTile(
                customerUID: user.uid,
                docId: documentSnapshot.id,
                serviceTitle: documentSnapshot["Service Title"],
                servicePrice: documentSnapshot["Service Price"],
                professionalUID: documentSnapshot["Professional UID"],
                serviceDescription: documentSnapshot["Service Description"],
              );
            },
          );
        },
      ),
    );
  }
}
