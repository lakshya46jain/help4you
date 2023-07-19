// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:device_info_plus/device_info_plus.dart';
// File Imports
import 'package:help4you/services/auth.dart';
import 'package:help4you/constants/custom_snackbar.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/constants/custom_text_field.dart';
import 'package:help4you/screens/onboarding_screen/components/password_reset_screen.dart';

class EmailAddressAuthScreen extends StatefulWidget {
  const EmailAddressAuthScreen({Key? key}) : super(key: key);

  @override
  State<EmailAddressAuthScreen> createState() => _EmailAddressAuthScreenState();
}

class _EmailAddressAuthScreenState extends State<EmailAddressAuthScreen> {
  // Text Field Variables
  String? emailAddress;
  String? password;

  // Device Details Variables
  String? platform;
  String? deviceType;
  String? osDetails;

  // Send Email Function
  Future launchEmail(
    String? toEmail,
    String? subject,
    String? message,
  ) async {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject!)}&body=${Uri.encodeFull(message!)}';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
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
          icon: const Icon(
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
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              child: const Row(
                children: [
                  Icon(
                    CupertinoIcons.question_circle,
                    size: 25.0,
                    color: Color(0xFFFEA700),
                  ),
                  SizedBox(width: 5.0),
                  Center(
                    child: Text(
                      "Help",
                      style: TextStyle(
                        color: Color(0xFFFEA700),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                Widget dialogButton(
                    String title, Color color, VoidCallback onTap) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 7.5,
                    ),
                    child: GestureDetector(
                      onTap: onTap,
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }

                AwesomeDialog(
                  context: context,
                  headerAnimationLoop: false,
                  dialogType: DialogType.warning,
                  body: Column(
                    children: [
                      dialogButton(
                        "Forgot Password",
                        const Color(0xFFFEA700),
                        () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PasswordResetScreen(),
                            ),
                          );
                        },
                      ),
                      dialogButton(
                        "Contact Support",
                        const Color(0xFF1C3857),
                        () async {
                          if (Platform.isIOS) {
                            final iosDeviceInfo =
                                await DeviceInfoPlugin().iosInfo;
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
                      ),
                      const SizedBox(height: 7.5),
                    ],
                  ),
                ).show();
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 10.0,
          bottom: 20.0,
        ),
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
                    style: GoogleFonts.balooPaaji2(
                      height: 1.3,
                      fontSize: 22.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  CustomFields(
                    type: "Normal",
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Enter Email Address...",
                    validator: (String? value) {
                      if (value!.isEmpty) {
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
                  const SizedBox(height: 10.0),
                  CustomFields(
                    type: "Normal",
                    maxLines: 1,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Enter Password...",
                    validator: (String? value) {
                      if (value!.isEmpty) {
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
                    if (formKey.currentState!.validate()) {
                      HapticFeedback.heavyImpact();
                      await AuthService().loginWithEmailAddressAndPassword(
                        emailAddress,
                        password,
                        context,
                      );
                    }
                  } catch (error) {
                    if (error.toString().contains("invalid-email")) {
                      showCustomSnackBar(
                        context,
                        CupertinoIcons.exclamationmark_circle,
                        Colors.red,
                        "Error!",
                        "The email entered is invalid. Please try again.",
                      );
                    } else if (error.toString().contains("user-not-found")) {
                      showCustomSnackBar(
                        context,
                        CupertinoIcons.exclamationmark_triangle,
                        Colors.orange,
                        "Warning!",
                        "There is no user associated with this email address. Please register.",
                      );
                    } else if (error.toString().contains("wrong-password")) {
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
