// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:url_launcher/url_launcher_string.dart';
import 'package:device_info_plus/device_info_plus.dart';
// File Imports
import 'package:help4you/screens/onboarding_screen/components/help_container.dart';
import 'package:help4you/screens/onboarding_screen/components/email_address_auth_screen.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  // Device Details Variables
  String platform;
  String deviceType;
  String osDetails;

  // Send Email Function
  Future launchEmail(
    String toEmail,
    String subject,
    String message,
  ) async {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Need help logging in?",
                style: TextStyle(
                  height: 1.3,
                  fontSize: 24.0,
                  color: Colors.black,
                  fontFamily: "BalooPaaji",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5.0),
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
              const SizedBox(height: 30.0),
              HelpContainer(
                icon: CupertinoIcons.mail_solid,
                title: "Already have an account?",
                description:
                    "You can sign in with your registered email address and password",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmailAddressAuthScreen(),
                    ),
                  );
                },
                buttonText: "Sign in with email address >",
              ),
              const SizedBox(height: 30.0),
              HelpContainer(
                icon: CupertinoIcons.chat_bubble_text_fill,
                title: "Can't sign in?",
                description:
                    "Get instant answers to your queries from our support team",
                onTap: () async {
                  if (Platform.isIOS) {
                    final iosDeviceInfo = await DeviceInfoPlugin().iosInfo;
                    setState(() {
                      platform = "iOS";
                      deviceType =
                          "${iosDeviceInfo.model} (${iosDeviceInfo.name})";
                      osDetails =
                          "${iosDeviceInfo.systemName} ${iosDeviceInfo.systemVersion}";
                    });
                  } else if (Platform.isAndroid) {
                    final androidDeviceInfo =
                        await DeviceInfoPlugin().androidInfo;
                    setState(() {
                      platform = "Android";
                      deviceType = androidDeviceInfo.model;
                      osDetails = androidDeviceInfo.version.toString();
                    });
                  }
                  await launchEmail(
                    "lakshyaj465@gmail.com",
                    "[Help4You-$platform]: Issue in logging in Help4You App",
                    "Full Name: \n\nPhone Number: \n\nIssue: \n\n| The Below Information Must Not Be Edited |\n\nApp Version: Alpha 1\nDevice Type: $deviceType\nOS Details: $osDetails",
                  );
                },
                buttonText: "Contact Customer Support >",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
