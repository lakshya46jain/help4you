// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:share/share.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:provider/provider.dart';
// File Imports
import 'package:help4you/services/auth.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/constants/expanded_button.dart';
import 'package:help4you/screens/settings_screen/edit_profile_toggle.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          if (user != null) ...[
            EditProfileToggle(),
            ExpandedButton(
              icon: FluentSystemIcons.ic_fluent_info_regular,
              text: "About Us",
              onPressed: () {},
            ),
            ExpandedButton(
              icon: FluentSystemIcons.ic_fluent_person_feedback_regular,
              text: "Feedback",
              onPressed: () {},
            ),
            ExpandedButton(
              icon: FluentSystemIcons.ic_fluent_star_regular,
              text: "Rate Us",
              onPressed: () {},
            ),
            ExpandedButton(
              icon: FluentSystemIcons.ic_fluent_share_regular,
              text: "Share Help4You",
              onPressed: () {
                Share.share(
                  "Have you tried the Help4You app? It's simple to book services like appliance repair, electricians, gardeners & more...\nTo download our app please visit https://www.help4you.webflow.io/download",
                  subject: "Try Help4You",
                );
              },
            ),
            ExpandedButton(
              icon: FluentSystemIcons.ic_fluent_sign_out_regular,
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
