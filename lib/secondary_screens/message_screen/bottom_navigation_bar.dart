// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports

class MessageNavBar extends StatelessWidget {
  final Function onChanged;
  final Function onPressed;
  final bool isMessageEmpty;
  final TextEditingController messageController;

  MessageNavBar({
    @required this.onChanged,
    @required this.onPressed,
    @required this.isMessageEmpty,
    @required this.messageController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: SafeArea(
        child: TextFormField(
          maxLines: 1,
          decoration: InputDecoration(
            suffix: (isMessageEmpty == true)
                ? GestureDetector(
                    onTap: onPressed,
                    child: Text(
                      "Send",
                      style: TextStyle(
                        height: 1.3,
                        fontSize: 20.0,
                        fontFamily: "BalooPaaji",
                        color: Color(0xFF1C3857),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : null,
            hintText: "Message...",
            hintStyle: TextStyle(
              fontSize: 18.0,
              color: Color(0xFF95989A),
              fontWeight: FontWeight.w600,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: Color(0xFF1C3857),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: Color(0xFF1C3857),
              ),
            ),
          ),
          controller: messageController,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
