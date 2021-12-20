// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:url_launcher/url_launcher.dart';
import 'package:device_info_plus/device_info_plus.dart';
// File Imports
import 'package:help4you/services/auth.dart';
import 'package:help4you/constants/custom_snackbar.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/constants/custom_text_field.dart';
import 'package:help4you/screens/onboarding_screen/components/password_reset_screen.dart';

class EmailAddressAuthScreen extends StatefulWidget {
  @override
  State<EmailAddressAuthScreen> createState() => _EmailAddressAuthScreenState();
}

class _EmailAddressAuthScreenState extends State<EmailAddressAuthScreen> {
  // Text Field Variables
  String emailAddress;
  String password;

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
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  // Global Key
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.chevron_left,
            size: 25.0,
            color: Color(0xFFFEA700),
          ),
          onPressed: () {
            Navigator.pop(context);
            FocusScope.of(context).unfocus();
          },
        ),
        actions: [
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Center(
                child: Text(
                  "Help",
                  style: TextStyle(
                    color: Color(0xFFFEA700),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            onTap: () {
              final pickerOptions = CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PasswordResetScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Password",
                    ),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () async {
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
                    child: Text(
                      "Contact Customer Support",
                    ),
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                  ),
                ),
              );
              showCupertinoModalPopup(
                context: context,
                builder: (context) => pickerOptions,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign in with your email address",
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 22.0,
                      color: Colors.black,
                      fontFamily: "BalooPaaji",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  CustomFields(
                    type: "Normal",
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Enter Email Address...",
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Email address field cannot be empty";
                      } else if (!value.contains("@")) {
                        return "Please enter a valid email address";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        emailAddress = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  CustomFields(
                    type: "Normal",
                    maxLines: 1,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Enter Password...",
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Password field cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            SafeArea(
              child: SignatureButton(
                onTap: () async {
                  try {
                    if (formKey.currentState.validate()) {
                      HapticFeedback.heavyImpact();
                      await AuthService().loginWithEmailAddressAndPassword(
                        emailAddress,
                        password,
                        context,
                      );
                    }
                  } catch (error) {
                    if (error.code == "invalid-email") {
                      showCustomSnackBar(
                        context,
                        CupertinoIcons.exclamationmark_circle,
                        Colors.red,
                        "Error!",
                        "The email entered is invalid. Please try again.",
                      );
                    } else if (error.code == "user-not-found") {
                      showCustomSnackBar(
                        context,
                        CupertinoIcons.exclamationmark_triangle,
                        Colors.orange,
                        "Warning!",
                        "There is no user associated with this email address. Please register.",
                      );
                    } else if (error.code == "wrong-password") {
                      showCustomSnackBar(
                        context,
                        CupertinoIcons.exclamationmark_circle,
                        Colors.red,
                        "Error!",
                        "The password entered is invalid. Please try again.",
                      );
                    }
                  }
                },
                withIcon: true,
                text: "CONTINUE",
                icon: CupertinoIcons.chevron_right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
