// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/screens/home_screen/professional_toggle.dart';

class Body extends StatelessWidget {
  final String occupation;

  Body({
    @required this.occupation,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("H4Y Users Database")
          .where("Account Type", isEqualTo: "Professional")
          .where("Occupation", isEqualTo: occupation)
          .snapshots(),
      builder: (context, snapshot) {
        return ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
            return ProfessionalsToggle(
              uid: documentSnapshot["User UID"],
              profilePicture: documentSnapshot["Profile Picture"],
              fullName: documentSnapshot["Full Name"],
              occupation: documentSnapshot["Occupation"],
              phoneNumber: documentSnapshot["Phone Number"],
              services: 0,
              rating: 0,
            );
          },
        );
      },
    );
  }
}
