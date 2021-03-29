// Flutter Imports
import 'package:flutter/material.dart';
import 'package:help4you/screens/about_us_screen/about_us.dart';
// Dependency Imports
import 'package:share/share.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
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
              icon: FluentIcons.info_24_regular,
              text: "About Us",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutUs(),
                  ),
                );
              },
            ),
            ExpandedButton(
              icon: FluentIcons.person_feedback_24_regular,
              text: "Feedback",
              onPressed: () {},
            ),
            ExpandedButton(
              icon: FluentIcons.star_24_regular,
              text: "Rate Us",
              onPressed: () {},
            ),
            ExpandedButton(
              icon: FluentIcons.share_24_regular,
              text: "Share Help4You",
              onPressed: () {
                Share.share(
                  "Have you tried the Help4You app? It's simple to book services like appliance repair, electricians, gardeners & more...\nTo download our app please visit https://www.help4you.webflow.io/download",
                  subject: "Try Help4You",
                );
              },
            ),
            ExpandedButton(
              icon: FluentIcons.sign_out_24_regular,
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
