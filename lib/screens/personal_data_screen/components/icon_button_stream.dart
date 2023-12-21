// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:firebase_storage/firebase_storage.dart';
// File Imports
import 'package:help4you/services/auth.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/constants/custom_snackbar.dart';

class IconButtonStream extends StatelessWidget {
  final Help4YouUser? user;
  final File? imageFile;
  final GlobalKey<FormState>? formKey;
  final String? countryCode;
  final String? nonInternationalNumber;
  final String? fullName;
  final String? phoneIsoCode;

  const IconButtonStream({
    Key? key,
    required this.user,
    required this.imageFile,
    required this.formKey,
    required this.countryCode,
    required this.nonInternationalNumber,
    required this.fullName,
    required this.phoneIsoCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        UserDataCustomer? userData = snapshot.data as UserDataCustomer?;
        return IconButton(
          icon: const Icon(
            CupertinoIcons.checkmark_alt,
            size: 24.0,
            color: Color(0xFFFEA700),
          ),
          onPressed: () async {
            // Upload Picture to Firebase
            Future setProfilePicture() async {
              // ignore: unnecessary_null_comparison
              if (imageFile != null) {
                Reference firebaseStorageRef = FirebaseStorage.instance
                    .ref()
                    .child(("H4Y Profile Pictures/${user!.uid}"));
                UploadTask uploadTask = firebaseStorageRef.putFile(imageFile!);
                await uploadTask;
                String downloadAddress =
                    await firebaseStorageRef.getDownloadURL();
                await DatabaseService(uid: user!.uid)
                    .updateProfilePicture(downloadAddress);
              } else {
                await DatabaseService(uid: user!.uid)
                    .updateProfilePicture(userData!.profilePicture);
              }
            }

            if (countryCode!.contains("+")) {
              countryCode!.replaceAll("+", "");
            }
            HapticFeedback.heavyImpact();
            FocusScope.of(context).unfocus();
            try {
              if (formKey!.currentState!.validate()) {
                String phoneNumber = "+$countryCode$nonInternationalNumber";
                if (userData!.phoneNumber != phoneNumber) {
                  await AuthService().phoneAuthentication(
                    fullName,
                    countryCode,
                    phoneIsoCode,
                    nonInternationalNumber,
                    phoneNumber,
                    userData.emailAddress,
                    "Update Phone Number",
                    context,
                  );
                  await DatabaseService(uid: user!.uid).updateUserData(
                    fullName,
                    countryCode,
                    phoneIsoCode,
                    nonInternationalNumber,
                    phoneNumber,
                    userData.emailAddress,
                  );
                } else {
                  await DatabaseService(uid: user!.uid)
                      .updateUserData(
                        fullName,
                        userData.countryCode,
                        userData.phoneIsoCode,
                        userData.nonInternationalNumber,
                        userData.phoneNumber,
                        userData.emailAddress,
                      )
                      .then(
                        (value) => Navigator.pop(context),
                      );
                }
              }
              setProfilePicture();
            } catch (error) {
              // ignore: use_build_context_synchronously
              showCustomSnackBar(
                context,
                CupertinoIcons.exclamationmark_circle,
                Colors.red,
                "Error!",
                "Please try updating your profile later.",
              );
            }
          },
        );
      },
    );
  }
}
