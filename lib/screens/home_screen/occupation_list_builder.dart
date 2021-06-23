// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/screens/all_services/all_services.dart';
import 'package:help4you/screens/home_screen/occupation_button.dart';

class OccupationListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Services",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontFamily: "BalooPaaji",
                  fontWeight: FontWeight.w900,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllServicesScreen(),
                    ),
                  );
                },
                child: Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color.fromRGBO(0, 147, 255, 1.0),
                    fontFamily: "BalooPaaji",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
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
        ),
      ],
    );
  }
}
