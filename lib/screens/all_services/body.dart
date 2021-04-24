// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/screens/home_screen/occupation_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("H4Y Occupation Database")
          .orderBy("Occupation")
          .snapshots(),
      builder: (context, snapshot) {
        return GridView.builder(
          itemCount: snapshot.data.docs.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
            return OccupationButton(
              imageUrl: documentSnapshot["Image URL"],
              occupation: documentSnapshot["Occupation"],
            );
          },
        );
      },
    );
  }
}
