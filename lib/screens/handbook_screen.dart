// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
// File Imports
import 'package:help4you/constants/back_button.dart';
import 'package:help4you/constants/policy_dialog.dart';
import 'package:help4you/constants/signature_button.dart';

class HandbookScreen extends StatefulWidget {
  @override
  _HandbookScreenState createState() => _HandbookScreenState();
}

class _HandbookScreenState extends State<HandbookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: CustomBackButton(),
        title: Text(
          "Our Handbook",
          style: TextStyle(
            fontSize: 25.0,
            color: Color(0xFF1C3857),
            fontFamily: "BalooPaaji",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SignatureButton(
              type: "Expanded",
              text: "About Help4You",
              icon: CupertinoIcons.question_circle,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return PolicyDialog(
                      mdFileName: 'about_help4you.md',
                    );
                  },
                  barrierDismissible: false,
                );
              },
            ),
            SignatureButton(
              type: "Expanded",
              text: "Terms and Conditions",
              icon: CupertinoIcons.folder_badge_person_crop,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return PolicyDialog(
                      mdFileName: 'terms_and_conditions.md',
                    );
                  },
                  barrierDismissible: false,
                );
              },
            ),
            SignatureButton(
              type: "Expanded",
              text: "Privacy Policy",
              icon: CupertinoIcons.lock_shield,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return PolicyDialog(
                      mdFileName: 'privacy_policy.md',
                    );
                  },
                  barrierDismissible: false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
