// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
// Dependency Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/screens/wrapper.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/constants/verification_container.dart';
import 'package:help4you/screens/register_profile_screen/register_profile_screen.dart';

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
    String fullName,
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
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
          _auth.signInWithCredential(phoneAuthCredential).then(
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
                  "https://firebasestorage.googleapis.com/v0/b/help4you-24c07.appspot.com/o/Default%20Profile%20Picture.png?alt=media&token=fd813e4d-80f9-4c2f-aa7a-b07602efaf09",
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
              onSubmit: (pin) {
                HapticFeedback.heavyImpact();
                FocusScope.of(context).unfocus();
                var credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: pin,
                );
                _auth.signInWithCredential(credential).then(
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
                        "https://firebasestorage.googleapis.com/v0/b/help4you-24c07.appspot.com/o/Default%20Profile%20Picture.png?alt=media&token=fd813e4d-80f9-4c2f-aa7a-b07602efaf09",
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterProfile(),
                        ),
                        (route) => false,
                      );
                    }
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

  // Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
