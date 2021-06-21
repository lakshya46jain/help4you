// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/constants/policy_dialog.dart';
import 'package:help4you/constants/expanded_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/banners/Help4You_Banner.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
            height: 200.0,
          ),
          SizedBox(
            height: 7.5,
          ),
          ExpandedButton(
            text: "About Help4You",
            icon: FluentIcons.question_circle_24_regular,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return PolicyDialog(
                    mdFileName: 'about_help4you.md',
                  );
                },
              );
            },
          ),
          ExpandedButton(
            text: "Terms and Conditions",
            icon: FluentIcons.person_accounts_24_regular,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return PolicyDialog(
                    mdFileName: 'terms_and_conditions.md',
                  );
                },
              );
            },
          ),
          ExpandedButton(
            text: "Privacy Policy",
            icon: FluentIcons.lock_shield_24_regular,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return PolicyDialog(
                    mdFileName: 'privacy_policy.md',
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
