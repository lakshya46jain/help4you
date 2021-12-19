// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
// File Imports
import 'package:help4you/screens/onboarding_screen/components/help_container.dart';
import 'package:help4you/screens/onboarding_screen/components/email_address_auth_screen.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.xmark,
            size: 25.0,
            color: Color(0xFFFEA700),
          ),
          onPressed: () {
            Navigator.pop(context);
            FocusScope.of(context).unfocus();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Need help logging in?",
                style: TextStyle(
                  height: 1.3,
                  fontSize: 24.0,
                  color: Colors.black,
                  fontFamily: "BalooPaaji",
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                "Try the following",
                style: TextStyle(
                  height: 1.3,
                  fontSize: 18.0,
                  color: Colors.black.withOpacity(0.5),
                  fontFamily: "BalooPaaji",
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              HelpContainer(
                icon: CupertinoIcons.mail_solid,
                title: "Already have an account?",
                description:
                    "You can sign in with your registered email address and password",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmailAddressAuthScreen(),
                    ),
                  );
                },
                buttonText: "Sign in with email address >",
              ),
              SizedBox(height: 30.0),
              HelpContainer(
                icon: CupertinoIcons.chat_bubble_text_fill,
                title: "Can't sign in?",
                description:
                    "Get instant answers to your queries from our support team",
                onTap: () {},
                buttonText: "Contact Customer Support >",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
