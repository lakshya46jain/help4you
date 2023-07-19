// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/chat_room_model.dart';
import 'package:help4you/screens/message_list_screen/components/message_tile.dart';

class MessageListBody extends StatelessWidget {
  final Help4YouUser? user;

  const MessageListBody({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService(uid: user!.uid).chatRoomsData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ChatRoom>? chatRooms = snapshot.data as List<ChatRoom>?;
          return ListView.builder(
            itemCount: chatRooms!.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return MessageTile(
                user: user,
                chatRoomId: chatRooms[index].chatRoomId,
                professionalUID: chatRooms[index].professionalUID,
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
