// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
// File Imports
import 'package:help4you/secondary_screens/personal_data_screen/body.dart';
import 'package:help4you/secondary_screens/personal_data_screen/app_bar.dart';

class PersonalDataScreen extends StatefulWidget {
  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
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
          _imageFile = cropped;
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
            formKey: _formKey,
            fullName: fullName,
            phoneNumber: phoneNumber,
            phoneIsoCode: phoneIsoCode,
            nonInternationalNumber: nonInternationalNumber,
            imageFile: _imageFile,
          ),
        ),
        body: Body(
          fullName: fullName,
          imageFile: _imageFile,
          formKey: _formKey,
          onChanged1: (val) {
            setState(() => fullName = val);
          },
          onChanged2: (phone) {
            setState(
              () {
                phoneNumber = phone.completeNumber;
                phoneIsoCode = phone.countryISOCode;
                nonInternationalNumber = phone.number;
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
