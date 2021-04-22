// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// File Imports
import 'package:help4you/constants/back_button.dart';

class MessagesBar extends StatelessWidget {
  final String profilePicture;
  final String fullName;
  final String occupation;
  final String phoneNumber;

  MessagesBar({
    @required this.profilePicture,
    @required this.fullName,
    @required this.occupation,
    @required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white.withOpacity(0.5),
      leading: CustomBackButton(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Color(0xFFF5F6F9),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: profilePicture,
                fit: BoxFit.fill,
              ),
            ),
            radius: 21.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / (828 / 30),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fullName,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              Text(
                occupation,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            FluentIcons.call_24_regular,
            size: 27.0,
            color: Colors.black,
          ),
          onPressed: () {
            FlutterPhoneDirectCaller.callNumber(phoneNumber);
          },
        ),
      ],
    );
  }
}
