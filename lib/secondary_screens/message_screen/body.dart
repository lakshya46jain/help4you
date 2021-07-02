// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/secondary_screens/message_screen/bottom_navigation_bar.dart';

class Body extends StatefulWidget {
  final Function onChanged;
  final Function onPressed;
  final bool isMessageEmpty;
  final TextEditingController messageController;

  Body({
    @required this.onChanged,
    @required this.onPressed,
    @required this.isMessageEmpty,
    @required this.messageController,
  });

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            bottom: 0.0,
            right: 0.0,
            left: 0.0,
            child: MessageNavBar(
              onChanged: widget.onChanged,
              onPressed: widget.onPressed,
              isMessageEmpty: widget.isMessageEmpty,
              messageController: widget.messageController,
            ),
          ),
        ],
      ),
    );
  }
}
