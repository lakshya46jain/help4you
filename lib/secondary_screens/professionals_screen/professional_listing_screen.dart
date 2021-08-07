// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/constants/loading.dart';
import 'package:help4you/constants/back_button.dart';
import 'package:help4you/secondary_screens/professionals_screen/professional_toggle.dart';

class ProfessionalListingScreen extends StatelessWidget {
  final String occupation;

  ProfessionalListingScreen({
    @required this.occupation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: CustomBackButton(),
        title: Text(
          occupation,
          style: TextStyle(
            fontSize: 25.0,
            color: Color(0xFF1C3857),
            fontFamily: "BalooPaaji",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("H4Y Users Database")
            .where("Account Type", isEqualTo: "Professional")
            .where("Occupation", isEqualTo: occupation)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / (1792 / 600),
                    child: SvgPicture.asset(
                      "assets/graphics/Help4You_Illustration_6.svg",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Oops! Looks like no professionals are available in your area",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF1C3857),
                        fontFamily: "BalooPaaji",
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                  return ProfessionalsToggle(
                    professionalUID: documentSnapshot["User UID"],
                    profilePicture: documentSnapshot["Profile Picture"],
                    fullName: documentSnapshot["Full Name"],
                    occupation: documentSnapshot["Occupation"],
                    phoneNumber: documentSnapshot["Phone Number"],
                    rating: 0,
                  );
                },
              );
            }
          } else {
            return DoubleBounceLoading();
          }
        },
      ),
    );
  }
}
