// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
// Dependency Imports
import 'package:firebase_auth/firebase_auth.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/constants/verification_container.dart';

class AuthService {
  // Firebase Auth Instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create User Object Based on Firebase User
  Help4YouUser _userFromFirebase(User user) {
    return user != null ? Help4YouUser(uid: user.uid) : null;
  }

  // Authenticate User
  Stream<Help4YouUser> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  // Phone Authentication
  Future phoneAuthentication(
    String phoneIsoCode,
    String nonInternationalNumber,
    String phoneNumber,
    BuildContext context,
  ) async {
    if (kIsWeb) {
      // TODO: Add Firebase Phone Authentication for Web
    } else {
      _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          _auth.signInWithCredential(phoneAuthCredential).then(
            (UserCredential result) {
              // TODO: Navigate To Home Page
            },
          );
        },
        verificationFailed: (FirebaseAuthException exception) {
          return "Error";
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => VerificationContainer(
              text1: "",
              text2: "We have sent your code to $phoneNumber.",
              onSubmit: (pin) async {
                HapticFeedback.heavyImpact();
                FocusScope.of(context).unfocus();
                var credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: pin,
                );
                _auth.signInWithCredential(credential).then(
                  (UserCredential result) {
                    // TODO: Navigate To Home Page
                  },
                );
              },
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
        },
      );
    }
  }
}
