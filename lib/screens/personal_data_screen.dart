// Flutter Imports
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:help4you/constants/loading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:help4you/constants/custom_snackbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports
import 'package:help4you/services/auth.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/constants/custom_text_field.dart';
import 'package:help4you/screens/delete_account_screens/delete_phone_auth_screen.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({Key? key}) : super(key: key);

  @override
  PersonalDataScreenState createState() => PersonalDataScreenState();
}

class PersonalDataScreenState extends State<PersonalDataScreen> {
  // Text Field Variables
  String? fullName;
  String? countryCode;
  String? phoneIsoCode;
  String? nonInternationalNumber;
  bool loading = false;

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
    // ignore: unnecessary_null_comparison
    if (cropped == null) return null;
    return File(cropped.path);
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("H4Y Users Database")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        fullName = value.data()!["Full Name"];
        countryCode = value.data()!["Country Code"];
        phoneIsoCode = value.data()!["Phone ISO Code"];
        nonInternationalNumber = value.data()!["Non International Number"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser?>(context);

    if (countryCode!.contains("+")) {
      countryCode = countryCode!.replaceAll("+", "");
    }

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0.0,
              leading: const SignatureButton(type: "Back Button"),
              backgroundColor: Colors.transparent,
              title: Text(
                "Personal Data",
                style: GoogleFonts.balooPaaji2(
                  fontSize: 25.0,
                  color: const Color(0xFF1C3857),
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                StreamBuilder(
                  stream: DatabaseService(uid: user!.uid).userData,
                  builder: (context, snapshot) {
                    UserDataCustomer? userData =
                        snapshot.data as UserDataCustomer?;
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
                            Reference firebaseStorageRef = FirebaseStorage
                                .instance
                                .ref()
                                .child(("H4Y Profile Pictures/${user.uid}"));
                            UploadTask uploadTask =
                                firebaseStorageRef.putFile(imageFile!);
                            await uploadTask;
                            String downloadAddress =
                                await firebaseStorageRef.getDownloadURL();
                            await DatabaseService(uid: user.uid)
                                .updateProfilePicture(downloadAddress);
                          } else {
                            await DatabaseService(uid: user.uid)
                                .updateProfilePicture(userData!.profilePicture);
                          }
                        }

                        if (countryCode!.contains("+")) {
                          countryCode!.replaceAll("+", "");
                        }
                        HapticFeedback.heavyImpact();
                        FocusScope.of(context).unfocus();
                        try {
                          if (formKey.currentState!.validate()) {
                            String phoneNumber =
                                "+$countryCode$nonInternationalNumber";
                            if (userData!.phoneNumber != phoneNumber) {
                              setState(() {
                                loading = true;
                              });
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
                              await DatabaseService(uid: user.uid)
                                  .updateUserData(
                                fullName,
                                countryCode,
                                phoneIsoCode,
                                nonInternationalNumber,
                                phoneNumber,
                                userData.emailAddress,
                              );
                            } else {
                              setState(() {
                                loading = true;
                              });
                              await DatabaseService(uid: user.uid)
                                  .updateUserData(
                                fullName,
                                userData.countryCode,
                                userData.phoneIsoCode,
                                userData.nonInternationalNumber,
                                userData.phoneNumber,
                                userData.emailAddress,
                              );
                            }
                          }
                          setProfilePicture();
                          setState(() {
                            loading = false;
                          });
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
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
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 25.0),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        bottom: 10.0,
                      ),
                      child: StreamBuilder(
                        stream: DatabaseService(uid: user.uid).userData,
                        builder: (context, snapshot) {
                          UserDataCustomer? userData =
                              snapshot.data as UserDataCustomer?;
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                SizedBox(
                                  width: 108.0,
                                  height: 108.0,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    clipBehavior: Clip.none,
                                    children: [
                                      SizedBox(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          // ignore: unnecessary_null_comparison
                                          child: (imageFile != null)
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image:
                                                          FileImage(imageFile!),
                                                    ),
                                                  ),
                                                )
                                              : CachedNetworkImage(
                                                  imageUrl: userData!
                                                      .profilePicture
                                                      .toString(),
                                                  fit: BoxFit.fill,
                                                ),
                                        ),
                                      ),
                                      Positioned(
                                        right: -15,
                                        bottom: -10,
                                        child: SizedBox(
                                          width: 45.0,
                                          height: 45.0,
                                          child: GestureDetector(
                                            onTap: () {
                                              Widget dialogButton(
                                                  String title,
                                                  Color color,
                                                  VoidCallback onTap) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 15.0,
                                                    vertical: 7.5,
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: onTap,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: color,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          title,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18.0,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                        var camStatus =
                                                            await Permission
                                                                .camera.status;
                                                        var photosStatus =
                                                            await Permission
                                                                .photos.status;
                                                        if (camStatus
                                                            .isDenied) {
                                                          Permission.location
                                                              .request();
                                                        } else if (photosStatus
                                                            .isDenied) {
                                                          Permission.photos
                                                              .request();
                                                        } else if (camStatus
                                                                .isPermanentlyDenied ||
                                                            photosStatus
                                                                .isPermanentlyDenied) {
                                                          openAppSettings();
                                                        }
                                                        getImage(ImageSource
                                                                .camera)
                                                            .then(
                                                          (value) =>
                                                              Navigator.pop(
                                                                  context),
                                                        );
                                                      },
                                                    ),
                                                    dialogButton(
                                                      "Photo Library",
                                                      const Color(0xFF1C3857),
                                                      () async {
                                                        var camStatus =
                                                            await Permission
                                                                .camera.status;
                                                        var photosStatus =
                                                            await Permission
                                                                .photos.status;
                                                        if (camStatus
                                                            .isDenied) {
                                                          Permission.location
                                                              .request();
                                                        } else if (photosStatus
                                                            .isDenied) {
                                                          Permission.photos
                                                              .request();
                                                        } else if (camStatus
                                                                .isPermanentlyDenied ||
                                                            photosStatus
                                                                .isPermanentlyDenied) {
                                                          openAppSettings();
                                                        }
                                                        getImage(ImageSource
                                                                .gallery)
                                                            .then(
                                                          (value) =>
                                                              Navigator.pop(
                                                                  context),
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
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color:
                                                      const Color(0xFFF2F3F7),
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
                                const SizedBox(height: 35.0),
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
                                    readOnly: true,
                                    hintText:
                                        "Please link your email address...",
                                    keyboardType: TextInputType.emailAddress,
                                    initialValue: userData.emailAddress,
                                    onChanged: (val) {
                                      setState(() {
                                        fullName = val;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: CustomFields(
                                    type: "Phone",
                                    phoneIsoCode: userData.phoneIsoCode,
                                    nonInternationalNumber:
                                        userData.nonInternationalNumber,
                                    onChangedPhone: (phone) {
                                      setState(() {
                                        nonInternationalNumber = phone.number;
                                      });
                                    },
                                    onCountryChanged: (phone) {
                                      setState(() {
                                        countryCode = phone.dialCode;
                                        phoneIsoCode = phone.code;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 13.0),
                              ],
                            );
                          } else {
                            return Container();
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
                            builder: (context) =>
                                const DeleteAccPhoneAuthScreen(),
                          ),
                        );
                      },
                    ),
                    StreamBuilder(
                      stream: DatabaseService(uid: user.uid).userData,
                      builder: (context, snapshot) {
                        UserDataCustomer? userData =
                            snapshot.data as UserDataCustomer?;
                        if (snapshot.hasData) {
                          if (FirebaseAuth.instance.currentUser?.email ==
                              null) {
                            return SignatureButton(
                              type: "Expanded",
                              icon: CupertinoIcons.link,
                              text: "Link Email Address",
                              onTap: () {
                                AuthService().phoneAuthentication(
                                  fullName,
                                  countryCode,
                                  phoneIsoCode,
                                  nonInternationalNumber,
                                  "${userData!.countryCode}${userData.nonInternationalNumber}",
                                  "",
                                  "Link Email Address",
                                  context,
                                );
                              },
                            );
                          } else {
                            return Column(
                              children: [
                                SignatureButton(
                                  type: "Expanded",
                                  icon: CupertinoIcons.refresh,
                                  text: "Update Password",
                                  onTap: () {
                                    AuthService().phoneAuthentication(
                                      fullName,
                                      countryCode,
                                      phoneIsoCode,
                                      nonInternationalNumber,
                                      "+${userData!.countryCode}${userData.nonInternationalNumber}",
                                      "",
                                      "Update Password",
                                      context,
                                    );
                                  },
                                ),
                                SignatureButton(
                                  type: "Expanded",
                                  icon: CupertinoIcons.refresh,
                                  text: "Update Email Address",
                                  onTap: () {
                                    AuthService().phoneAuthentication(
                                      fullName,
                                      countryCode,
                                      phoneIsoCode,
                                      nonInternationalNumber,
                                      "+${userData!.countryCode}${userData.nonInternationalNumber}",
                                      "",
                                      "Update Email Address",
                                      context,
                                    );
                                  },
                                ),
                              ],
                            );
                          }
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        loading ? const Loading() : Container(),
      ],
    );
  }
}
