// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:google_fonts/google_fonts.dart';
// File Imports
import 'package:help4you/services/auth.dart';
import 'package:help4you/constants/custom_snackbar.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/constants/custom_text_field.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  // Text Field Variables
  String? emailAddress;
  String? password;

  // Global Key
  final formKey = GlobalKey<FormState>();
  final formKeyReset = GlobalKey<FormState>();

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                    "Forgot Password",
                    style: GoogleFonts.balooPaaji2(
                      height: 1.3,
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    "Provide us the email address of your Help4You account and we will send you an email with instructions to reset your password.",
                    style: GoogleFonts.balooPaaji2(
                      height: 1.3,
                      fontSize: 14.0,
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 20.0),
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
                ],
              ),
            ),
            SafeArea(
              child: SignatureButton(
                onTap: () async {
                  try {
                    if (formKey.currentState!.validate()) {
                      HapticFeedback.heavyImpact();
                      await AuthService()
                          .resetPassword(emailAddress)
                          .then(
                            (value) => showCustomSnackBar(
                              context,
                              CupertinoIcons.checkmark_alt_circle,
                              Colors.green,
                              "Congratulations!",
                              "Password reset link has been sent to $emailAddress",
                            ),
                          )
                          .then(
                            (value) => Navigator.pop(context),
                          );
                    }
                  } catch (error) {
                    if (error.toString().contains("invalid-email")) {
                      // ignore: use_build_context_synchronously
                      showCustomSnackBar(
                        context,
                        CupertinoIcons.exclamationmark_circle,
                        Colors.red,
                        "Error!",
                        "The email entered is invalid. Please try again.",
                      );
                    } else if (error.toString().contains("user-not-found")) {
                      // ignore: use_build_context_synchronously
                      showCustomSnackBar(
                        context,
                        CupertinoIcons.exclamationmark_triangle,
                        Colors.orange,
                        "Warning!",
                        "There is no user associated with this email address. Please register.",
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
