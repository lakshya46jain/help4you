// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/screens/home_screen/service_tiles.dart';

class ServiceTileBuilder extends StatelessWidget {
  final String uid;

  ServiceTileBuilder({
    this.uid,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("H4Y Users Database")
          .doc(uid)
          .collection("Services")
          .where("Visibility", isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        return ListView.builder(
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
        );
      },
    );
  }
}
