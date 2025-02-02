// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:share_plus/share_plus.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher_string.dart';
// File Imports
import 'package:help4you/services/auth.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/screens/handbook_screen.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/screens/personal_data_screen.dart';
import 'package:help4you/screens/profile_screen/components/profile_stream.dart';

class ProfileScreenBody extends StatefulWidget {
  final Help4YouUser? user;

  const ProfileScreenBody({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  Future<void> launchInApp(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  RateMyApp rateMyApp = RateMyApp(
    googlePlayIdentifier: 'com.help4youcompany.help4you',
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: unnecessary_null_comparison
      children: (widget.user != null)
          ? [
              const SizedBox(height: 70.0),
              const ProfileStream(),
              const Padding(
                padding: EdgeInsets.only(
                    right: 20.0, bottom: 5.0, top: 15.0, left: 20.0),
                child: Divider(
                  thickness: 1.0,
                  color: Color(0xFF95989A),
                ),
              ),
              SignatureButton(
                type: "Expanded",
                icon: CupertinoIcons.info_circle,
                text: "Our Handbook",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HandbookScreen(),
                    ),
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Divider(
                  thickness: 1.0,
                  color: Color(0xFF95989A),
                ),
              ),
              SignatureButton(
                type: "Expanded",
                icon: CupertinoIcons.person,
                text: "Personal Data",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PersonalDataScreen(),
                    ),
                  );
                },
              ),
              StreamBuilder(
                stream: DatabaseService(uid: widget.user!.uid).userData,
                builder: (context, snapshot) {
                  UserDataCustomer? userData =
                      snapshot.data as UserDataCustomer?;
                  if (snapshot.hasData) {
                    if (userData!.adminLevel! > 0) {
                      return SignatureButton(
                        type: "Expanded",
                        icon: CupertinoIcons.person_2,
                        text: "Admin Access",
                        onTap: () {},
                      );
                    } else {
                      return Container(
                        width: 0.0,
                        height: 0.0,
                        color: Colors.transparent,
                      );
                    }
                  } else {
                    return Container();
                  }
                },
              ),
              SignatureButton(
                type: "Expanded",
                icon: CupertinoIcons.square_arrow_right,
                text: "Sign Out",
                onTap: () async {
                  return AuthService().signOut();
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Divider(
                  thickness: 1.0,
                  color: Color(0xFF95989A),
                ),
              ),
              SignatureButton(
                type: "Expanded",
                icon: CupertinoIcons.star,
                text: "Rate Us",
                onTap: () async {
                  await rateMyApp.showStarRateDialog(
                    context,
                    title: 'Rate Help4You',
                    message:
                        'Did you like your experience with Help4You? Then take a little bit of your time to leave a rating:',
                    actionsBuilder: (context, stars) {
                      return [
                        TextButton(
                          child: const Text('Ok'),
                          onPressed: () async {
                            HapticFeedback.lightImpact();
                            await rateMyApp
                                .callEvent(RateMyAppEventType.rateButtonPressed)
                                .then(
                                  (value) =>
                                      Navigator.pop<RateMyAppDialogButton>(
                                    context,
                                    RateMyAppDialogButton.rate,
                                  ),
                                );
                          },
                        ),
                      ];
                    },
                    dialogStyle: const DialogStyle(
                      titleAlign: TextAlign.center,
                      messageAlign: TextAlign.center,
                      messagePadding: EdgeInsets.only(bottom: 20),
                    ),
                    starRatingOptions: const StarRatingOptions(),
                    onDismissed: () => rateMyApp.callEvent(
                      RateMyAppEventType.laterButtonPressed,
                    ),
                  );
                },
              ),
              SignatureButton(
                type: "Expanded",
                icon: CupertinoIcons.chat_bubble_2,
                text: "Feedback",
                onTap: () {
                  launchInApp(
                    "https://forms.monday.com/forms/59fb3ed6751002d5a4e1be3fb9a80ac0?r=use1",
                    // TODO: Change to feedback form link
                  );
                },
              ),
              SignatureButton(
                type: "Expanded",
                icon: CupertinoIcons.share,
                text: "Share Help4You",
                onTap: () {
                  Share.share(
                    "Have you tried the Help4You app? It's simple to book services like appliance repair, electricians, gardeners & more...\nTo download our app please visit https://www.help4you.webflow.io/download",
                    // TODO: Change to landing page link
                    subject: "Try Help4You",
                  );
                },
              ),
            ]
          : [
              Container(),
            ],
    );
  }
}
