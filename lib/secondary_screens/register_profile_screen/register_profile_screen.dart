// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
// File Imports
import 'package:help4you/secondary_screens/register_profile_screen/app_bar.dart';
import 'package:help4you/secondary_screens/register_profile_screen/body.dart';

class RegisterProfileScreen extends StatefulWidget {
  @override
  _RegisterProfileScreenState createState() => _RegisterProfileScreenState();
}

class _RegisterProfileScreenState extends State<RegisterProfileScreen> {
  // Text Field Variables
  String fullName;
  String phoneNumber;
  String phoneIsoCode;
  String nonInternationalNumber;

  // Global Key
  final _formKey = GlobalKey<FormState>();

  // Active Image File
  File _imageFile;

  // Crop Selected Image
  Future cropImage(PickedFile selectedFile) async {
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
          _imageFile = cropped;
        },
      );
    }
  }

  // Select Image Via Image Picker
  Future getImage(ImageSource source) async {
    final selected = await ImagePicker().getImage(source: source);
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
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height / (1792 / 100),
          ),
          child: RegisterAppBar(),
        ),
        body: Body(
          fullName: fullName,
          imageFile: _imageFile,
          formKey: _formKey,
          onChanged: (val) {
            setState(() => fullName = val);
          },
          onPhoneNumberChange: (
            String number,
            String internationalizedPhoneNumber,
            String isoCode,
          ) {
            setState(
              () {
                phoneNumber = internationalizedPhoneNumber;
                phoneIsoCode = isoCode;
                nonInternationalNumber = number;
              },
            );
          },
          onPressed1: () => getImage(
            ImageSource.camera,
          ),
          onPressed2: () => getImage(
            ImageSource.gallery,
          ),
        ),
      ),
    );
  }
}
