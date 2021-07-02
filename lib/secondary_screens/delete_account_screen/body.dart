// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/constants/phone_number_field.dart';

class Body extends StatelessWidget {
  final String phoneNumber;
  final String phoneIsoCode;
  final String nonInternationalNumber;
  final Function onChanged;

  Body({
    this.phoneNumber,
    this.phoneIsoCode,
    this.nonInternationalNumber,
    this.onChanged,
  });

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
              "Delete Account",
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
              "We are sad to see you go.",
              style: TextStyle(
                color: Color(0xFF95989A),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / (1792 / 100),
            ),
            PhoneNumberTextField(
              phoneIsoCode: phoneIsoCode,
              nonInternationalNumber: nonInternationalNumber,
              onChanged: onChanged,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / (1792 / 50),
            ),
            SignatureButton(
              onTap: () {},
              withIcon: true,
              text: "CONTINUE",
              icon: FluentIcons.arrow_right_24_filled,
            ),
          ],
        ),
      ),
    );
  }
}
