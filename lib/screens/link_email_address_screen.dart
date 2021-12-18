// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:help4you/services/auth.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/screens/bottom_nav_bar.dart';
import 'package:help4you/constants/custom_snackbar.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/constants/custom_text_field.dart';

class LinkEmailAddressScreen extends StatefulWidget {
  @override
  State<LinkEmailAddressScreen> createState() => _LinkEmailAddressScreenState();
}

class _LinkEmailAddressScreenState extends State<LinkEmailAddressScreen> {
  // Text Field Variables
  String emailAddress;
  String password;

  RegExp regex = new RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );

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
            "Link Email Address",
            style: TextStyle(
              fontSize: 25.0,
              color: Color(0xFF1C3857),
              fontFamily: "BalooPaaji",
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      child: CustomTextField(
                        keyboardType: TextInputType.name,
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      child: CustomTextField(
                        maxLines: 1,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: "Enter Password...",
                        validator: (String value) {
                          if (value.isEmpty) {
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      child: CustomTextField(
                        maxLines: 1,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: "Confirm Password...",
                        validator: (String value) {
                          if (value.isEmpty) {
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
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  child: SignatureButton(
                    withIcon: true,
                    text: "CONTINUE",
                    icon: CupertinoIcons.chevron_right,
                    onTap: () async {
                      try {
                        if (formKey.currentState.validate()) {
                          await AuthService().linkPhoneAndEmailCredential(
                            user.uid,
                            emailAddress,
                            password,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavBar(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
