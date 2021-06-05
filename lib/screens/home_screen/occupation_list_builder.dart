// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/screens/home_screen/occupation_button.dart';

class OccupationListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("H4Y Occupation Database")
            .orderBy("Occupation")
            .snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
              return OccupationButton(
                imageUrl: documentSnapshot["Image URL"],
                occupation: documentSnapshot["Occupation"],
              );
            },
          );
        },
      ),
    );
  }
}
