// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
// File Imports
import 'package:help4you/services/auth.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/screens/bottom_nav_bar.dart';
import 'package:help4you/constants/custom_snackbar.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/constants/custom_text_field.dart';

class UpdateEmailAddressScreen extends StatefulWidget {
  const UpdateEmailAddressScreen({Key key}) : super(key: key);

  @override
  State<UpdateEmailAddressScreen> createState() =>
      _UpdateEmailAddressScreenState();
}

class _UpdateEmailAddressScreenState extends State<UpdateEmailAddressScreen> {
  // Text Field Variables
  String emailAddress;

  // Global Key
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Text(
            "Update Email Address",
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
                          if (formKey.currentState.validate()) {
                            await AuthService()
                                .updateEmailAddress(
                                  user.uid,
                                  emailAddress,
                                )
                                .then(
                                  (value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavBar(),
                                    ),
                                  ),
                                );
                          }
                        } catch (error) {
                          if (error.code == "email-already-in-use") {
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
    );
  }
}
