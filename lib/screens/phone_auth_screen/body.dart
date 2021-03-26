// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// File Imports
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/constants/phone_number_field.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // Text Field Variables
  String phoneNumber;
  String phoneIsoCode;
  String nonInternationalNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / (1792 / 50),
            ),
            Text(
              "Welcome!",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / (1792 / 20),
            ),
            Text(
              "Call for desired day to day services in just a few clicks.",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / (1792 / 100),
            ),
            PhoneNumberTextField(
              phoneIsoCode: "",
              nonInternationalNumber: "",
              onPhoneNumberChange: (
                String number,
                String internationalizedPhoneNumber,
                String isoCode,
              ) {
                setState(
                  () {
                    phoneNumber = internationalizedPhoneNumber;
                    phoneIsoCode = isoCode;
                    nonInternationalNumber = number;
                  },
                );
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / (1792 / 50),
            ),
            SignatureButton(
              onTap: () {
                // TODO: Give Continue Button Functionality
              },
              text: "Continue",
              icon: FontAwesomeIcons.chevronRight,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / (1792 / 785),
            ),
            GestureDetector(
              onTap: () {
                // TODO: Give Terms & Conditions Button Functionality
              },
              child: Text(
                "By continuing you confirm that you agree \nwith our Terms and Conditions",
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
