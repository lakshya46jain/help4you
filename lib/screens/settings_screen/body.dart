// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:ant_icons/ant_icons.dart';
// File Imports
import 'package:help4you/services/auth.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/constants/expanded_button.dart';
import 'package:help4you/screens/settings_screen/stream_builder.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          if (user != null) ...[
            ProfileCardStreamBuilder(),
            ExpandedButton(
              icon: AntIcons.info_circle_outline,
              text: "About Us",
              onPressed: () {},
            ),
            ExpandedButton(
              icon: AntIcons.question_circle_outline,
              text: "Feedback",
              onPressed: () {},
            ),
            ExpandedButton(
              icon: AntIcons.star_outline,
              text: "Rate Us",
              onPressed: () {},
            ),
            ExpandedButton(
              icon: AntIcons.share_alt,
              text: "Share Help4You",
              onPressed: () {},
            ),
            ExpandedButton(
              icon: AntIcons.logout_outline,
              text: "Sign Out",
              onPressed: () {
                return AuthService().signOut();
              },
            ),
          ] else ...[
            Container(),
          ],
        ],
      ),
    );
  }
}
