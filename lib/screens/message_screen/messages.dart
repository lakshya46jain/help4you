// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/screens/message_screen/body.dart';
import 'package:help4you/screens/message_screen/app_bar.dart';
import 'package:help4you/screens/message_screen/bottom_navigation_bar.dart';

class MessageScreen extends StatefulWidget {
  final String uid;
  final String profilePicture;
  final String fullName;
  final String occupation;
  final String phoneNumber;

  MessageScreen({
    @required this.uid,
    @required this.profilePicture,
    @required this.fullName,
    @required this.occupation,
    @required this.phoneNumber,
  });

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  // Text Field Variables
  String message;

  // Message Controller
  final TextEditingController _messageController = TextEditingController();

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
          child: MessagesBar(
            profilePicture: widget.profilePicture,
            fullName: widget.fullName,
            occupation: widget.occupation,
            phoneNumber: widget.phoneNumber,
          ),
        ),
        body: Body(),
        bottomNavigationBar: MessageNavBar(
          onChanged: (value) {
            setState(
              () {
                message = value;
              },
            );
          },
          onPressed: () {
            // TODO: Implement Sending Messages and Recieving Messages
          },
          messageController: _messageController,
        ),
      ),
    );
  }
}
