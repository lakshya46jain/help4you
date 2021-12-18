// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:help4you/screens/onboarding_screen/components/password_reset_screen.dart';
// Dependency Imports
// File Imports
import 'package:help4you/services/auth.dart';
import 'package:help4you/constants/custom_snackbar.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/constants/custom_text_field.dart';

class EmailAddressAuthScreen extends StatefulWidget {
  @override
  State<EmailAddressAuthScreen> createState() => _EmailAddressAuthScreenState();
}

class _EmailAddressAuthScreenState extends State<EmailAddressAuthScreen> {
  // Text Field Variables
  String emailAddress;
  String password;

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
                    "Enter your credentials",
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 24.0,
                      color: Colors.black,
                      fontFamily: "BalooPaaji",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  CustomTextField(
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
                  SizedBox(
                    height: 10.0,
                  ),
                  CustomTextField(
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
                  SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PasswordResetScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot your password? Click here to reset it.",
                      style: TextStyle(
                        height: 1.3,
                        fontSize: 16.0,
                        color: Color(0xFF1C3857),
                        fontFamily: "BalooPaaji",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
