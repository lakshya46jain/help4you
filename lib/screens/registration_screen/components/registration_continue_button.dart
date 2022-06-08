// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:firebase_storage/firebase_storage.dart';
// File Imports
import 'package:help4you/services/auth.dart';
import 'package:help4you/screens/wrapper.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/constants/custom_snackbar.dart';
import 'package:help4you/constants/signature_button.dart';

class RegistrationContinueButton extends StatelessWidget {
  final File imageFile;
  final Help4YouUser user;
  final UserDataCustomer userData;
  final GlobalKey<FormState> formKey;
  final String emailAddress;
  final String password;
  final String fullName;

  const RegistrationContinueButton({
    Key key,
    @required this.imageFile,
    @required this.user,
    @required this.userData,
    @required this.formKey,
    @required this.emailAddress,
    @required this.password,
    @required this.fullName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 15.0,
      ),
      child: SignatureButton(
        withIcon: true,
        text: "CONTINUE",
        icon: CupertinoIcons.chevron_right,
        onTap: () async {
          // Upload Picture to Firebase
          Future setProfilePicture() async {
            if (imageFile != null) {
              Reference firebaseStorageRef = FirebaseStorage.instance
                  .ref()
                  .child(("H4Y Profile Pictures/${user.uid}"));
              UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
              await uploadTask;
              String downloadAddress =
                  await firebaseStorageRef.getDownloadURL();
              await DatabaseService(uid: user.uid)
                  .updateProfilePicture(downloadAddress);
            } else {
              await DatabaseService(uid: user.uid)
                  .updateProfilePicture(userData.profilePicture);
            }
          }

          HapticFeedback.heavyImpact();
          try {
            if (formKey.currentState.validate()) {
              await AuthService().linkPhoneAndEmailCredential(
                user.uid,
                emailAddress,
                password,
              );
              await DatabaseService(uid: user.uid).updateUserData(
                fullName ?? userData.fullName,
                userData.countryCode,
                userData.phoneIsoCode,
                userData.nonInternationalNumber,
                userData.phoneNumber,
                emailAddress,
              );
              setProfilePicture().then(
                (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Wrapper(),
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
            } else {
              showCustomSnackBar(
                context,
                CupertinoIcons.exclamationmark_circle,
                Colors.red,
                "Error!",
                "Please try registering your profile later.",
              );
            }
          }
        },
      ),
    );
  }
}
