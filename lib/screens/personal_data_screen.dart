// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports
import 'package:help4you/services/database.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/constants/loading.dart';
import 'package:help4you/constants/back_button.dart';
import 'package:help4you/constants/custom_snackbar.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/constants/custom_text_field.dart';
import 'package:help4you/constants/phone_number_field.dart';
import 'package:help4you/screens/delete_phone_auth_screen.dart';

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
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: CustomBackButton(),
          title: Text(
            "Personal Data",
            style: TextStyle(
              fontSize: 25.0,
              color: Color(0xFF1C3857),
              fontFamily: "BalooPaaji",
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            StreamBuilder(
              stream: DatabaseService(uid: user.uid).userData,
              builder: (context, snapshot) {
                UserDataCustomer userData = snapshot.data;
                return IconButton(
                  icon: Icon(
                    CupertinoIcons.checkmark_alt,
                    size: 24.0,
                    color: Color(0xFFFEA700),
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
                          userData.phoneIsoCode ?? userData.phoneIsoCode,
                          userData.nonInternationalNumber ??
                              userData.nonInternationalNumber,
                          userData.phoneNumber ?? userData.phoneNumber,
                        );
                        Navigator.pop(context);
                      }
                      setProfilePicture();
                    } catch (error) {
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
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    bottom: 10.0,
                  ),
                  child: StreamBuilder(
                    stream: DatabaseService(uid: user.uid).userData,
                    builder: (context, snapshot) {
                      UserDataCustomer userData = snapshot.data;
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  (1792 / 230),
                              width: MediaQuery.of(context).size.width /
                                  (828 / 230),
                              child: Stack(
                                fit: StackFit.expand,
                                clipBehavior: Clip.none,
                                children: [
                                  SizedBox(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: (imageFile != null)
                                          ? Image.file(
                                              imageFile,
                                              fit: BoxFit.fill,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: userData.profilePicture,
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                    right: -15,
                                    bottom: -10,
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              (1792 / 92),
                                      width: MediaQuery.of(context).size.width /
                                          (828 / 92),
                                      child: GestureDetector(
                                        onTap: () {
                                          final pickerOptions =
                                              CupertinoActionSheet(
                                            title: Text("Profile Picture"),
                                            message: Text(
                                              "Please select how you want to upload the profile picture",
                                            ),
                                            actions: [
                                              CupertinoActionSheetAction(
                                                onPressed: () => getImage(
                                                  ImageSource.camera,
                                                ),
                                                child: Text(
                                                  "Camera",
                                                ),
                                              ),
                                              CupertinoActionSheetAction(
                                                onPressed: () => getImage(
                                                  ImageSource.gallery,
                                                ),
                                                child: Text(
                                                  "Gallery",
                                                ),
                                              ),
                                            ],
                                            cancelButton:
                                                CupertinoActionSheetAction(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Cancel",
                                              ),
                                            ),
                                          );
                                          showCupertinoModalPopup(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                pickerOptions,
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Color(0xFFF2F3F7),
                                              border: Border.all(
                                                color: Colors.white,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: Offset(0, 15),
                                                  blurRadius: 20.0,
                                                  color: Color(0xFFDADADA),
                                                ),
                                              ]),
                                          child: Icon(
                                            CupertinoIcons.camera,
                                            color: Color(0xFF1C3857),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  (1792 / 75),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 10.0,
                              ),
                              child: CustomTextField(
                                keyboardType: TextInputType.name,
                                hintText: "Enter Full Name...",
                                initialValue: userData.fullName,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Name field cannot be empty";
                                  } else if (value.length < 2) {
                                    return "Name must be atleast 2 characters long";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (val) {
                                  setState(() {
                                    fullName = val;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  (1792 / 30),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: PhoneNumberTextField(
                                phoneIsoCode: userData.phoneIsoCode,
                                nonInternationalNumber:
                                    userData.nonInternationalNumber,
                                onChanged: (phone) {
                                  setState(() {
                                    nonInternationalNumber = phone.number;
                                  });
                                },
                                onCountryChanged: (phone) {
                                  setState(() {
                                    countryCode = phone.countryCode;
                                    phoneIsoCode = phone.countryISOCode;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  (1792 / 30),
                            ),
                          ],
                        );
                      } else {
                        return DoubleBounceLoading();
                      }
                    },
                  ),
                ),
                SignatureButton(
                  type: "Expanded",
                  icon: CupertinoIcons.delete,
                  text: "Delete Account",
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeleteAccPhoneAuthScreen(),
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
