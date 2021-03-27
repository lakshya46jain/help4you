// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
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
      title: Text(
        "Edit Profile",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ),
      actions: [
        StreamBuilder<UserDataCustomer>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            UserDataCustomer userData = snapshot.data;
            return Padding(
              padding: EdgeInsets.all(14.5),
              child: GestureDetector(
                child: Text(
                  "Done",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                onTap: () async {
                  // Upload Picture to Firebase
                  Future setProfilePicture() async {
                    if (imageFile == null) {
                      await DatabaseService(uid: user.uid)
                          .updateProfilePicture(userData.profilePicture);
                    } else {
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
                        nonInternationalNumber ??
                            userData.nonInternationalNumber,
                      );
                    }
                    if (imageFile == null) {
                      await DatabaseService(uid: user.uid).updateProfilePicture(
                        "https://firebasestorage.googleapis.com/v0/b/help4you-24c07.appspot.com/o/Default%20Profile%20Picture.png?alt=media&token=fd813e4d-80f9-4c2f-aa7a-b07602efaf09",
                      );
                    } else {
                      setProfilePicture();
                    }
                    showCustomSnackBar(
                      context,
                      FontAwesomeIcons.checkCircle,
                      Colors.white,
                      "Your profile was updated successfully.",
                      Colors.white,
                      Colors.green,
                    );
                  } catch (error) {
                    showCustomSnackBar(
                      context,
                      FontAwesomeIcons.exclamationCircle,
                      Colors.white,
                      "There was an error updating your profile. Please try again later.",
                      Colors.white,
                      Colors.red,
                    );
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
