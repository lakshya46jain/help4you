// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/secondary_screens/delete_account_screen/app_bar.dart';
import 'package:help4you/secondary_screens/delete_account_screen/body.dart';

class DeleteAccountScreen extends StatefulWidget {
  @override
  _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  // Text Field Variables
  String phoneNumber;
  String phoneIsoCode;
  String nonInternationalNumber;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height / (1792 / 100),
          ),
          child: DeleteAccountAppBar(),
        ),
        body: Body(
          phoneNumber: phoneNumber,
          phoneIsoCode: phoneIsoCode,
          nonInternationalNumber: nonInternationalNumber,
          onChanged: (phone) {
            setState(
              () {
                phoneNumber = phone.completeNumber;
                phoneIsoCode = phone.countryISOCode;
                nonInternationalNumber = phone.number;
              },
            );
          },
        ),
      ),
    );
  }
}
