// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/constants/expanded_button.dart';

class AdminStreamBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        UserDataCustomer userData = snapshot.data;
        if (snapshot.hasData) {
          if (userData.adminLevel > 0) {
            return ExpandedButton(
              icon: FluentIcons.people_24_regular,
              text: "Admin Access",
              onPressed: () {},
            );
          } else {
            return Container(
              width: 0.0,
              height: 0.0,
              color: Colors.transparent,
            );
          }
        } else {
          return Container(
            height: 0.0,
            width: 0.0,
          );
        }
      },
    );
  }
}
