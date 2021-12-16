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
import 'package:help4you/screens/wrapper.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/constants/loading.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/constants/custom_snackbar.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/constants/custom_text_field.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Text Field Variables
  String fullName;
  String emailAddress;
  String password;

  RegExp regex = new RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );

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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Register Details",
          style: TextStyle(
            fontSize: 25.0,
            color: Color(0xFF1C3857),
            fontFamily: "BalooPaaji",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
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
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        height: 115.0,
                        width: 115.0,
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
                                height: 46.0,
                                width: 46.0,
                                child: GestureDetector(
                                  onTap: () {
                                    final pickerOptions = CupertinoActionSheet(
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
                                      cancelButton: CupertinoActionSheetAction(
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
                        height: 25.0,
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 10.0,
                        ),
                        child: CustomTextField(
                          keyboardType: TextInputType.name,
                          hintText: "Enter Email Address...",
                          initialValue: userData.fullName,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Email address field cannot be empty";
                            } else if (!value.contains("@")) {
                              return "Please enter a valid email address";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              emailAddress = val;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 10.0,
                        ),
                        child: CustomTextField(
                          keyboardType: TextInputType.name,
                          hintText: "Enter Password...",
                          initialValue: userData.fullName,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Password field cannot be empty";
                            } else if (!regex.hasMatch(value)) {
                              return "Please include atleast one (a-z), (0-9) & special symbol";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
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
                                Reference firebaseStorageRef =
                                    FirebaseStorage.instance.ref().child(
                                        ("H4Y Profile Pictures/" + user.uid));
                                UploadTask uploadTask =
                                    firebaseStorageRef.putFile(imageFile);
                                await uploadTask;
                                String downloadAddress =
                                    await firebaseStorageRef.getDownloadURL();
                                await DatabaseService(uid: user.uid)
                                    .updateProfilePicture(downloadAddress);
                              } else {
                                await DatabaseService(uid: user.uid)
                                    .updateProfilePicture(
                                        userData.profilePicture);
                              }
                            }

                            HapticFeedback.heavyImpact();
                            try {
                              if (formKey.currentState.validate()) {
                                await DatabaseService(uid: user.uid)
                                    .updateUserData(
                                  fullName ?? userData.fullName,
                                  userData.phoneIsoCode,
                                  userData.nonInternationalNumber,
                                  userData.phoneNumber,
                                );
                                setProfilePicture().then(
                                  (value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Wrapper(),
                                    ),
                                  ),
                                );
                              }
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
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return DoubleBounceLoading();
              }
            },
          ),
        ),
      ),
    );
  }
}
