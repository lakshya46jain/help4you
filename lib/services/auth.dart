// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/screens/wrapper.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/constants/custom_snackbar.dart';
import 'package:help4you/screens/registration_screen/registration_screen.dart';
import 'package:help4you/screens/onboarding_screen/components/verification_screen.dart';

class AuthService {
  // Firebase Auth Instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Create User Object Based on Firebase User
  Help4YouUser _userFromFirebase(User user) {
    return user != null ? Help4YouUser(uid: user.uid) : null;
  }

  // Authenticate User
  Stream<Help4YouUser> get user {
    return auth.authStateChanges().map(_userFromFirebase);
  }

  // Verification Completed Future Function
  Future<void> verificationCompleted(
    PhoneAuthCredential credential,
    String fullName,
    String phoneIsoCode,
    String nonInternationalNumber,
    String phoneNumber,
    BuildContext context,
  ) async {
    await auth.signInWithCredential(credential).then(
      (UserCredential result) async {
        User user = result.user;
        DocumentSnapshot ds = await FirebaseFirestore.instance
            .collection("H4Y Users Database")
            .doc(user.uid)
            .get();
        if (ds.exists) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Wrapper(),
            ),
            (route) => false,
          );
        } else {
          await DatabaseService(uid: user.uid).updateUserData(
            fullName,
            phoneNumber,
            phoneIsoCode,
            nonInternationalNumber,
          );
          await DatabaseService(uid: user.uid).updateProfilePicture(
            "https://drive.google.com/uc?export=view&id=1Fis4yJe7_d_RROY7JdSihM2--GH5aqbe",
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Wrapper(),
            ),
            (route) => false,
          );
        }
      },
    );
  }

  // Firebase Authentication Exception Future Function
  Future<void> verificationFailed(
    FirebaseAuthException exception,
    BuildContext context,
  ) async {
    if (exception.code == 'invalid-phone-number') {
      showCustomSnackBar(
        context,
        FluentIcons.error_circle_24_regular,
        Colors.red,
        "Error!",
        "Please enter a valid phone number.",
      );
    } else if (exception.code == 'too-many-requests') {
      showCustomSnackBar(
        context,
        FluentIcons.warning_24_regular,
        Colors.orange,
        "Warning!",
        "We have recieved too many requests from this number. Please try again later.",
      );
    }
  }

  // Phone Authentication
  Future phoneAuthentication(
    String fullName,
    String phoneIsoCode,
    String nonInternationalNumber,
    String phoneNumber,
    BuildContext context,
  ) async {
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 180),
      verificationCompleted: (PhoneAuthCredential credential) async {
        verificationCompleted(
          credential,
          fullName,
          phoneIsoCode,
          nonInternationalNumber,
          phoneNumber,
          context,
        );
      },
      verificationFailed: (FirebaseAuthException exception) async {
        verificationFailed(
          exception,
          context,
        );
      },
      codeSent: (String verificationId, int resendToken) async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationScreen(
              phoneIsoCode: phoneIsoCode,
              nonInternationalNumber: nonInternationalNumber,
              phoneNumber: phoneNumber,
              submitOTP: (pin) {
                HapticFeedback.heavyImpact();
                var credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: pin,
                );
                auth.signInWithCredential(credential).then(
                  (UserCredential result) async {
                    User user = result.user;
                    DocumentSnapshot ds = await FirebaseFirestore.instance
                        .collection("H4Y Users Database")
                        .doc(user.uid)
                        .get();
                    if (ds.exists) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Wrapper(),
                        ),
                        (route) => false,
                      );
                    } else {
                      await DatabaseService(uid: user.uid).updateUserData(
                        fullName,
                        phoneNumber,
                        phoneIsoCode,
                        nonInternationalNumber,
                      );
                      await DatabaseService(uid: user.uid).updateProfilePicture(
                        "https://drive.google.com/uc?export=view&id=1Fis4yJe7_d_RROY7JdSihM2--GH5aqbe",
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                ).catchError(
                  (error) {
                    if (error.code == 'invalid-verification-code') {
                      showCustomSnackBar(
                        context,
                        FluentIcons.error_circle_24_regular,
                        Colors.red,
                        "Error!",
                        "Invalid verification code entered. Please try again later.",
                      );
                    }
                  },
                );
              },
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        verificationId = verificationId;
      },
    );
  }

  // Sign Out
  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (error) {
      return null;
    }
  }
}
