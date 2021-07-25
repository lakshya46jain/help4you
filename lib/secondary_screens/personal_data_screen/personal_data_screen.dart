// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/constants/expanded_button.dart';
import 'package:help4you/secondary_screens/delete_account_screen.dart';
import 'package:help4you/secondary_screens/personal_data_screen/app_bar.dart';
import 'package:help4you/secondary_screens/personal_data_screen/edit_profile_stream.dart';

class PersonalDataScreen extends StatefulWidget {
  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  // Text Field Variables
  String fullName;
  String countryCode;
  String phoneIsoCode;
  String nonInternationalNumber;

  // Global Key
  final formKey = GlobalKey<FormState>();

  // Active Image File
  File imageFile;

  // Crop Selected Image
  Future cropImage(XFile selectedFile) async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: selectedFile.path,
      aspectRatio: CropAspectRatio(
        ratioX: 1.0,
        ratioY: 1.0,
      ),
      cropStyle: CropStyle.circle,
    );
    if (cropped != null) {
      setState(
        () {
          imageFile = cropped;
        },
      );
    }
  }

  // Select Image Via Image Picker
  Future getImage(ImageSource source) async {
    final selected = await ImagePicker().pickImage(source: source);
    if (selected != null) {
      cropImage(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: PersonalDataAppBar(
            formKey: formKey,
            fullName: fullName,
            phoneNumber: "$countryCode$nonInternationalNumber",
            phoneIsoCode: phoneIsoCode,
            nonInternationalNumber: nonInternationalNumber,
            imageFile: imageFile,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 25.0,
                ),
                EditProfileStreamBuilder(
                  imageFile: imageFile,
                  fullName: fullName,
                  onChanged1: (val) {
                    setState(() {
                      fullName = val;
                    });
                  },
                  onChanged2: (phone) {
                    setState(() {
                      nonInternationalNumber = phone.number;
                    });
                  },
                  onPressed1: () => getImage(
                    ImageSource.camera,
                  ),
                  onPressed2: () => getImage(
                    ImageSource.gallery,
                  ),
                  onCountryChanged: (phone) {
                    setState(() {
                      countryCode = phone.countryCode;
                      phoneIsoCode = phone.countryISOCode;
                    });
                  },
                ),
                ExpandedButton(
                  icon: FluentIcons.delete_24_regular,
                  text: "Delete Account",
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeleteAccountScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
