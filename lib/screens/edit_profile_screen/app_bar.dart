// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:firebase_storage/firebase_storage.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/constants/back_button.dart';
import 'package:help4you/constants/custom_snackbar.dart';

class EditProfileAppBar extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String fullName;
  final String phoneNumber;
  final String phoneIsoCode;
  final String nonInternationalNumber;
  final String profilePicture;
  final File imageFile;

  EditProfileAppBar({
    this.formKey,
    this.fullName,
    this.phoneNumber,
    this.phoneIsoCode,
    this.nonInternationalNumber,
    this.profilePicture,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    // Get User from Provider Package
    final user = Provider.of<Help4YouUser>(context);

    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: CustomBackButton(),
      title: Text(
        "Edit Profile",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ),
      actions: [
        StreamBuilder(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            UserDataCustomer userData = snapshot.data;
            return IconButton(
              icon: Icon(
                FluentIcons.checkmark_24_regular,
                size: 24.0,
                color: Colors.black,
              ),
              onPressed: () async {
                // Upload Picture to Firebase
                Future setProfilePicture() async {
                  if (imageFile != null) {
                    Reference firebaseStorageRef = FirebaseStorage.instance
                        .ref()
                        .child(("H4Y Profile Pictures/" + user.uid));
                    UploadTask uploadTask =
                        firebaseStorageRef.putFile(imageFile);
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
                FocusScope.of(context).unfocus();
                try {
                  if (formKey.currentState.validate()) {
                    await DatabaseService(uid: user.uid).updateUserData(
                      fullName ?? userData.fullName,
                      phoneNumber ?? userData.phoneNumber,
                      phoneIsoCode ?? userData.phoneIsoCode,
                      nonInternationalNumber ?? userData.nonInternationalNumber,
                    );
                    Navigator.pop(context);
                  }
                  setProfilePicture();
                } catch (error) {
                  showCustomSnackBar(
                    context,
                    FluentIcons.error_circle_24_regular,
                    Colors.red,
                    "Error!",
                    "Please try updating your profile later.",
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
