// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
// File Imports
import 'package:help4you/secondary_screens/phone_auth_screen/phone_authentication.dart';

class WelcomeBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhoneAuthScreen(),
          ),
        );
      },
      child: Container(
        height: 100.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.deepOrangeAccent,
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Text(
              'Get Started',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}