// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports

class MessageNavBar extends StatelessWidget {
  final Function onChanged;
  final Function onPressed;
  final TextEditingController messageController;

  MessageNavBar({
    @required this.onChanged,
    @required this.onPressed,
    @required this.messageController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white.withOpacity(0.5),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Message...",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                controller: messageController,
                onChanged: onChanged,
              ),
            ),
            IconButton(
              icon: Icon(
                FluentIcons.send_16_filled,
                color: Colors.deepOrangeAccent,
              ),
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
