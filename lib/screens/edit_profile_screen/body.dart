// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:ant_icons/ant_icons.dart';
// File Imports
import 'package:help4you/constants/expanded_button.dart';
import 'package:help4you/screens/edit_profile_screen/stream_builder.dart';

class Body extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final File imageFile;
  final String fullName;
  final Function onChanged;
  final Function onPhoneNumberChange;
  final Function onPressed1;
  final Function onPressed2;

  Body({
    this.formKey,
    this.imageFile,
    this.fullName,
    this.onChanged,
    this.onPhoneNumberChange,
    this.onPressed1,
    this.onPressed2,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / (1792 / 25),
            ),
            EditProfileStreamBuilder(
              imageFile: imageFile,
              fullName: fullName,
              onChanged: onChanged,
              onPhoneNumberChange: onPhoneNumberChange,
              onPressed1: onPressed1,
              onPressed2: onPressed2,
            ),
            ExpandedButton(
              icon: AntIcons.delete_outline,
              text: "Delete Account",
              onPressed: () {
                HapticFeedback.lightImpact();
                // TODO: Give Delete Account Button
              },
            ),
          ],
        ),
      ),
    );
  }
}
