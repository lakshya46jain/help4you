// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help4you/constants/loading.dart';
// File Imports
import 'package:help4you/screens/home_screen/service_tiles.dart';

class ServiceTileBuilder extends StatelessWidget {
  final String uid;

  ServiceTileBuilder({
    this.uid,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("H4Y Users Database")
          .doc(uid)
          .collection("Services")
          .where("Visibility", isEqualTo: true)
          .where("User UID", isEqualTo: uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                return ServiceTiles(
                  professionalUID: uid,
                  docId: documentSnapshot.id,
                  serviceTitle: documentSnapshot["Service Title"],
                  serviceDescription: documentSnapshot["Service Description"],
                  servicePrice: documentSnapshot["Service Price"],
                );
              },
            ),
          );
        } else if (!snapshot.hasData) {
          return Center(
            child: Text("No Services Provided By The User"),
          );
        } else {
          return PouringHourGlassPageLoad();
        }
      },
    );
  }
}
