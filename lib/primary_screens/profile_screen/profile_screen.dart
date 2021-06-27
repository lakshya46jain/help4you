// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:share/share.dart';
import 'package:provider/provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/services/auth.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/constants/expanded_button.dart';
import 'package:help4you/secondary_screens/handbook_screen/handbook_screen.dart';
import 'package:help4you/secondary_screens/personal_data_screen/personal_data_screen.dart';
import 'package:help4you/primary_screens/profile_screen/admin_stream.dart';
import 'package:help4you/primary_screens/profile_screen/profile_stream.dart';

class SettingsScreens extends StatefulWidget {
  @override
  _SettingsScreensState createState() => _SettingsScreensState();
}

class _SettingsScreensState extends State<SettingsScreens> {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (user != null) ...[
                SizedBox(
                  height: 70.0,
                ),
                ProfileStreamBuilder(),
                Padding(
                  padding: EdgeInsets.only(
                      right: 20.0, bottom: 5.0, top: 15.0, left: 20.0),
                  child: Divider(
                    thickness: 1.0,
                    color: Color(0xFF95989A),
                  ),
                ),
                ExpandedButton(
                  icon: FluentIcons.info_24_regular,
                  text: "Our Handbook",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HandbookScreen(),
                      ),
                    );
                  },
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                  child: Divider(
                    thickness: 1.0,
                    color: Color(0xFF95989A),
                  ),
                ),
                ExpandedButton(
                  icon: FluentIcons.person_24_regular,
                  text: "Personal Data",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonalDataScreen(),
                      ),
                    );
                  },
                ),
                AdminStreamBuilder(),
                ExpandedButton(
                  icon: FluentIcons.sign_out_24_regular,
                  text: "Sign Out",
                  onPressed: () {
                    return AuthService().signOut();
                  },
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                  child: Divider(
                    thickness: 1.0,
                    color: Color(0xFF95989A),
                  ),
                ),
                ExpandedButton(
                  icon: FluentIcons.star_24_regular,
                  text: "Rate Us",
                  onPressed: () {},
                ),
                ExpandedButton(
                  icon: FluentIcons.person_feedback_24_regular,
                  text: "Feedback",
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
              ] else ...[
                Container(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
