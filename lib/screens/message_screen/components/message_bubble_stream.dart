// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/constants/loading.dart';
import 'package:help4you/models/messages_model.dart';
import 'package:help4you/screens/message_screen/messages_screen.dart';
import 'package:help4you/screens/message_screen/components/message_bubble.dart';

class MessageBubbleStream extends StatelessWidget {
  final Help4YouUser user;
  final MessageScreen widget;

  MessageBubbleStream({
    @required this.user,
    @required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService(uid: user.uid, professionalUID: widget.uid)
          .messagesData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Messages> messages = snapshot.data;
          return ListView.builder(
            reverse: true,
            padding: EdgeInsets.symmetric(
              vertical: 0.0,
              horizontal: 20.0,
            ),
            physics: BouncingScrollPhysics(),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return MessageBubble(
                chatRoomId: "${user.uid}\_${widget.uid}",
                messageId: messages[index].messageId,
                type: messages[index].type,
                profilePicture: widget.profilePicture,
                message: messages[index].message,
                isSentByMe: (messages[index].sender == user.uid) ? true : false,
              );
            },
          );
        } else {
          return DoubleBounceLoading();
        }
      },
    );
  }
}
