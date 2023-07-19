// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports
import 'package:help4you/services/database.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/constants/custom_text_field.dart';
import 'package:help4you/screens/registration_screen/components/registration_continue_button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  // Text Field Variables
  String? fullName;
  String? emailAddress;
  String? password;

  RegExp regex = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );

  // Global Key
  final formKey = GlobalKey<FormState>();

  // Active Image File
  File? imageFile;

  // Select Image Via Image Picker
  Future getImage(ImageSource source) async {
    final selected = await ImagePicker().pickImage(source: source);
    if (selected == null) return;
    File? image = File(selected.path);
    image = await cropImage(selected);
    setState(() {
      imageFile = image!;
    });
  }

  // Crop Selected Image
  Future<File?> cropImage(XFile selectedFile) async {
    CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: selectedFile.path,
      aspectRatio: const CropAspectRatio(
        ratioX: 1.0,
        ratioY: 1.0,
      ),
      cropStyle: CropStyle.rectangle,
    );
    if (cropped == null) return null;
    return File(cropped.path);
  }

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser?>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Register Details",
          style: GoogleFonts.balooPaaji2(
            fontSize: 25.0,
            color: const Color(0xFF1C3857),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            bottom: 10.0,
          ),
          child: StreamBuilder(
            stream: DatabaseService(uid: user!.uid).userData,
            builder: (context, snapshot) {
              UserDataCustomer? userData = snapshot.data as UserDataCustomer?;
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 15.0),
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
                                // ignore: unnecessary_null_comparison
                                child: (imageFile != null)
                                    ? Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: FileImage(imageFile!),
                                          ),
                                        ),
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: userData!.profilePicture!,
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
                                    Widget dialogButton(String title,
                                        Color color, VoidCallback onTap) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0,
                                          vertical: 7.5,
                                        ),
                                        child: GestureDetector(
                                          onTap: onTap,
                                          child: Container(
                                            padding: const EdgeInsets.all(15.0),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: color,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Center(
                                              child: Text(
                                                title,
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    AwesomeDialog(
                                      context: context,
                                      headerAnimationLoop: false,
                                      dialogType: DialogType.info,
                                      body: Column(
                                        children: [
                                          dialogButton(
                                            "Camera",
                                            const Color(0xFFFEA700),
                                            () async {
                                              var camStatus = await Permission
                                                  .camera.status;
                                              var photosStatus =
                                                  await Permission
                                                      .photos.status;
                                              if (camStatus.isDenied) {
                                                Permission.location.request();
                                              } else if (photosStatus
                                                  .isDenied) {
                                                Permission.photos.request();
                                              } else if (camStatus
                                                      .isPermanentlyDenied ||
                                                  photosStatus
                                                      .isPermanentlyDenied) {
                                                openAppSettings();
                                              }
                                              getImage(ImageSource.camera).then(
                                                (value) =>
                                                    Navigator.pop(context),
                                              );
                                            },
                                          ),
                                          dialogButton(
                                            "Photo Library",
                                            const Color(0xFF1C3857),
                                            () async {
                                              var camStatus = await Permission
                                                  .camera.status;
                                              var photosStatus =
                                                  await Permission
                                                      .photos.status;
                                              if (camStatus.isDenied) {
                                                Permission.location.request();
                                              } else if (photosStatus
                                                  .isDenied) {
                                                Permission.photos.request();
                                              } else if (camStatus
                                                      .isPermanentlyDenied ||
                                                  photosStatus
                                                      .isPermanentlyDenied) {
                                                openAppSettings();
                                              }
                                              getImage(ImageSource.gallery)
                                                  .then(
                                                (value) =>
                                                    Navigator.pop(context),
                                              );
                                            },
                                          ),
                                          const SizedBox(height: 7.5),
                                        ],
                                      ),
                                    ).show();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: const Color(0xFFF2F3F7),
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(0, 15),
                                            blurRadius: 20.0,
                                            color: Color(0xFFDADADA),
                                          ),
                                        ]),
                                    child: const Icon(
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
                      const SizedBox(height: 25.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 10.0,
                        ),
                        child: CustomFields(
                          type: "Normal",
                          keyboardType: TextInputType.name,
                          hintText: "Enter Full Name...",
                          initialValue: userData!.fullName,
                          validator: (String? value) {
                            if (value!.isEmpty) {
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 10.0,
                        ),
                        child: CustomFields(
                          type: "Normal",
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Enter Email Address...",
                          initialValue: userData.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 10.0,
                        ),
                        child: CustomFields(
                          type: "Normal",
                          maxLines: 1,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: "Enter Password...",
                          validator: (String? value) {
                            if (value!.isEmpty) {
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 10.0,
                        ),
                        child: CustomFields(
                          type: "Normal",
                          maxLines: 1,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: "Confirm Password...",
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Confirm Password field cannot be empty";
                            } else if (value != password) {
                              return "The password entered does not match";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      RegistrationContinueButton(
                        imageFile: imageFile,
                        user: user,
                        userData: userData,
                        formKey: formKey,
                        emailAddress: emailAddress,
                        password: password,
                        fullName: fullName,
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
