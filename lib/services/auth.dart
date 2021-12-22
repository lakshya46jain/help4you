// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/screens/wrapper.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/screens/bottom_nav_bar.dart';
import 'package:help4you/constants/custom_snackbar.dart';
import 'package:help4you/screens/registration_screen/registration_screen.dart';
import 'package:help4you/screens/update_password_screen.dart';
import 'package:help4you/screens/update_num_verification.dart';
import 'package:help4you/screens/link_email_address_screen.dart';
import 'package:help4you/screens/delete_account_screens/delete_verification_screen.dart';
import 'package:help4you/screens/update_email_address_screen.dart';
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

  // Firebase Authentication Exception Future Function
  Future<void> verificationFailed(
    FirebaseAuthException exception,
    BuildContext context,
  ) async {
    if (exception.code == 'invalid-phone-number') {
      showCustomSnackBar(
        context,
        CupertinoIcons.exclamationmark_circle,
        Colors.red,
        "Error!",
        "Please enter a valid phone number.",
      );
    } else if (exception.code == 'too-many-requests') {
      showCustomSnackBar(
        context,
        CupertinoIcons.exclamationmark_triangle,
        Colors.orange,
        "Warning!",
        "We have recieved too many requests from this number. Please try again later.",
      );
    }
  }

  // Phone Authentication
  Future phoneAuthentication(
    String fullName,
    String countryCode,
    String phoneIsoCode,
    String nonInternationalNumber,
    String phoneNumber,
    String emailAddress,
    String motive,
    BuildContext context,
  ) async {
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException exception) async {
        verificationFailed(
          exception,
          context,
        );
      },
      codeSent: (String verificationId, int resendToken) async {
        if (motive == "Registration") {
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
                          countryCode,
                          phoneIsoCode,
                          nonInternationalNumber,
                          phoneNumber,
                          emailAddress,
                        );
                        await DatabaseService(uid: user.uid)
                            .updateProfilePicture(
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
                          CupertinoIcons.exclamationmark_circle,
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
        } else if (motive == "Delete Account") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeleteAccVerificationScreen(
                phoneNumber: phoneNumber,
                phoneIsoCode: phoneIsoCode,
                nonInternationalNumber: nonInternationalNumber,
                submitOTP: (pin) {
                  HapticFeedback.heavyImpact();
                  PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: pin,
                  );
                  auth.currentUser.delete();
                  signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Wrapper(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
          );
        } else if (motive == "Update Phone Number" ||
            motive == "Link Email Address" ||
            motive == "Update Email Address" ||
            motive == "Update Password") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateNumVerificationScreen(
                phoneNumber: phoneNumber,
                phoneIsoCode: phoneIsoCode,
                nonInternationalNumber: nonInternationalNumber,
                submitOTP: (pin) async {
                  var phoneCredential = PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: pin,
                  );
                  await auth.currentUser
                      .updatePhoneNumber(phoneCredential)
                      .catchError(
                    (error) {
                      if (error.code == 'invalid-verification-code') {
                        showCustomSnackBar(
                          context,
                          CupertinoIcons.exclamationmark_circle,
                          Colors.red,
                          "Error!",
                          "Invalid verification code entered. Please try again later.",
                        );
                      }
                    },
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        if (motive == "Update Phone Number") {
                          return BottomNavBar();
                        } else if (motive == "Link Email Address") {
                          return LinkEmailAddressScreen();
                        } else if (motive == "Update Email Address") {
                          return UpdateEmailAddressScreen();
                        } else if (motive == "Update Password") {
                          return UpdatePasswordScreen();
                        } else {
                          return null;
                        }
                      },
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
          );
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        verificationId = verificationId;
      },
    );
  }

  // Linking Phone & Email Credential
  Future linkPhoneAndEmailCredential(
    String uid,
    String emailAddress,
    String password,
  ) async {
    var credential = EmailAuthProvider.credential(
      email: emailAddress,
      password: password,
    );
    await auth.currentUser.linkWithCredential(credential).then(
          (value) => DatabaseService(uid: uid).updateEmailAddress(emailAddress),
        );
  }

  // Login With Email Address & Password
  Future loginWithEmailAddressAndPassword(
    String emailAddress,
    String password,
    BuildContext context,
  ) async {
    await auth
        .signInWithEmailAndPassword(
          email: emailAddress,
          password: password,
        )
        .then(
          (value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Wrapper(),
              ),
              (route) => false),
        );
  }

  // Reset Password
  Future resetPassword(
    String emailAddress,
  ) async {
    await auth.sendPasswordResetEmail(email: emailAddress);
  }

  // Updating Email Address
  Future updateEmailAddress(
    String uid,
    String emailAddress,
  ) async {
    await auth.currentUser.updateEmail(emailAddress).then(
          (value) => DatabaseService(uid: uid).updateEmailAddress(emailAddress),
        );
  }

  // Updating Password
  Future updatePassword(
    String password,
  ) async {
    await auth.currentUser.updatePassword(password);
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
