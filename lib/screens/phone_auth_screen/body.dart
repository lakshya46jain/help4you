// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:fluentui_icons/fluentui_icons.dart';
// File Imports
import 'package:help4you/services/auth.dart';
import 'package:help4you/constants/policy_dialog.dart';
import 'package:help4you/constants/custom_snackbar.dart';
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
              onTap: () async {
                HapticFeedback.heavyImpact();
                FocusScope.of(context).unfocus();
                dynamic result = await AuthService().phoneAuthentication(
                  "",
                  phoneIsoCode,
                  nonInternationalNumber,
                  phoneNumber,
                  context,
                );
                if (nonInternationalNumber == "") {
                  showCustomSnackBar(
                    context,
                    FluentSystemIcons.ic_fluent_error_circle_regular,
                    Colors.white,
                    "Please enter your phone number.",
                    Colors.white,
                    Colors.red,
                  );
                } else if (result == "Error") {
                  showCustomSnackBar(
                    context,
                    FluentSystemIcons.ic_fluent_error_circle_regular,
                    Colors.white,
                    "There was an error while verifying your account. Please try again later.",
                    Colors.white,
                    Colors.red,
                  );
                }
              },
              text: "Continue",
              icon: FluentSystemIcons.ic_fluent_arrow_right_filled,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / (1792 / 785),
            ),
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                showDialog(
                  context: context,
                  builder: (context) {
                    return PolicyDialog(
                      mdFileName: 'terms_and_conditions.md',
                    );
                  },
                );
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
