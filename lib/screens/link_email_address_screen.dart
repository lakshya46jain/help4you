// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
// File Imports
import 'package:help4you/services/auth.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/constants/loading.dart';
import 'package:help4you/screens/bottom_nav_bar.dart';
import 'package:help4you/constants/custom_snackbar.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/constants/custom_text_field.dart';

class LinkEmailAddressScreen extends StatefulWidget {
  const LinkEmailAddressScreen({Key? key}) : super(key: key);

  @override
  State<LinkEmailAddressScreen> createState() => _LinkEmailAddressScreenState();
}

class _LinkEmailAddressScreenState extends State<LinkEmailAddressScreen> {
  // Text Field Variables
  String? emailAddress;
  String? password;
  bool loading = false;

  RegExp regex = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );

  // Global Key
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser?>(context);

    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0.0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              title: Text(
                "Link Email Address",
                style: GoogleFonts.balooPaaji2(
                  fontSize: 25.0,
                  color: const Color(0xFF1C3857),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: SafeArea(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 10.0,
                          ),
                          child: CustomFields(
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 10.0,
                          ),
                          child: CustomFields(
                            type: "Normal",
                            maxLines: 1,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: "Enter Password...",
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Password field cannot be empty";
                              } else if (!regex.hasMatch(value)) {
                                return "Please include atleast one (a-z), (0-9) & special symbol";
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 10.0,
                          ),
                          child: CustomFields(
                            type: "Normal",
                            maxLines: 1,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: "Confirm Password...",
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Confirm Password field cannot be empty";
                              } else if (value != password) {
                                return "The password entered does not match";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: SignatureButton(
                          withIcon: true,
                          text: "CONTINUE",
                          icon: CupertinoIcons.chevron_right,
                          onTap: () async {
                            try {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                await AuthService().linkPhoneAndEmailCredential(
                                  user!.uid,
                                  emailAddress,
                                  password,
                                );
                                setState(() {
                                  loading = false;
                                });
                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const BottomNavBar(),
                                  ),
                                  (route) => false,
                                );
                              }
                            } catch (error) {
                              setState(() {
                                loading = false;
                              });
                              if (error
                                  .toString()
                                  .contains("email-already-in-use")) {
                                // ignore: use_build_context_synchronously
                                showCustomSnackBar(
                                  context,
                                  CupertinoIcons.exclamationmark_circle,
                                  Colors.red,
                                  "Error!",
                                  "Email is already in use. Please try again later.",
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        loading ? const Loading() : Container(),
      ],
    );
  }
}
