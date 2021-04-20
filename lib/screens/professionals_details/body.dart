// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// File Imports
import 'package:help4you/constants/custom_media_button.dart';

class Body extends StatelessWidget {
  final String uid;
  final String profilePicture;
  final String fullName;
  final String occupation;
  final String phoneNumber;

  Body({
    @required this.uid,
    @required this.profilePicture,
    @required this.fullName,
    @required this.occupation,
    @required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.296),
                height: 500,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                    top: 40.0,
                    right: 20.0,
                  ),
                  // TODO: Add Service Tile Child
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      occupation,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      fullName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomMediaButton(
                              onTap: () {
                                FlutterPhoneDirectCaller.callNumber(
                                  phoneNumber,
                                );
                              },
                              icon: FluentIcons.phone_laptop_24_regular,
                              text: "Call",
                            ),
                            CustomMediaButton(
                              onTap: () {
                                // TODO: Add Messaging Feature To Button
                              },
                              icon: FluentIcons.chat_28_regular,
                              text: "Message",
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 15),
                                  blurRadius: 20.0,
                                  color: Color(0xFFDADADA),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: CachedNetworkImage(
                                imageUrl: profilePicture,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
