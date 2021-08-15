// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/constants/loading.dart';
import 'package:help4you/secondary_screens/professionals_screen/service_tile.dart';

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
        if (snapshot.hasData) {
          if (snapshot.data.docs.length == 0) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.61,
                child: SvgPicture.asset(
                  "assets/graphics/Help4You_Illustration_6.svg",
                ),
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                return ServiceTiles(
                  professionalId: uid,
                  serviceId: documentSnapshot.id,
                  serviceTitle: documentSnapshot["Service Title"],
                  serviceDescription: documentSnapshot["Service Description"],
                  servicePrice: documentSnapshot["Service Price"],
                );
              },
            );
          }
        } else {
          return DoubleBounceLoading();
        }
      },
    );
  }
}
