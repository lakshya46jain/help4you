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

class RegistrationContinueButton extends StatefulWidget {
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
  State<RegistrationContinueButton> createState() =>
      _RegistrationContinueButtonState();
}

class _RegistrationContinueButtonState
    extends State<RegistrationContinueButton> {
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
            if (widget.imageFile != null) {
              Reference firebaseStorageRef = FirebaseStorage.instance
                  .ref()
                  .child(("H4Y Profile Pictures/${widget.user.uid}"));
              UploadTask uploadTask =
                  firebaseStorageRef.putFile(widget.imageFile);
              await uploadTask;
              String downloadAddress =
                  await firebaseStorageRef.getDownloadURL();
              await DatabaseService(uid: widget.user.uid)
                  .updateProfilePicture(downloadAddress);
            } else {
              await DatabaseService(uid: widget.user.uid)
                  .updateProfilePicture(widget.userData.profilePicture);
            }
          }

          HapticFeedback.heavyImpact();
          try {
            if (widget.formKey.currentState.validate()) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const Wrapper(),
                ),
                (route) => false,
              );
              await AuthService().linkPhoneAndEmailCredential(
                widget.user.uid,
                widget.emailAddress,
                widget.password,
              );
              await DatabaseService(uid: widget.user.uid).updateUserData(
                widget.fullName ?? widget.userData.fullName,
                widget.userData.countryCode,
                widget.userData.phoneIsoCode,
                widget.userData.nonInternationalNumber,
                widget.userData.phoneNumber,
                widget.emailAddress,
              );
              setProfilePicture();
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
