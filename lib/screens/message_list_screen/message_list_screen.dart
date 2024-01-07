// Flutter Imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/chat_room_model.dart';
import 'package:help4you/screens/message_list_screen/components/message_tile.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({Key? key}) : super(key: key);

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  void getPermission() async {
    var notificationStatus = await Permission.notification.status;
    if (notificationStatus.isDenied) {
      Permission.notification.request();
    } else if (notificationStatus.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  void initState() {
    getPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser?>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: StreamBuilder(
        stream: DatabaseService(uid: user!.uid).chatRoomsData,
        builder: (context, snapshot) {
          List<ChatRoom>? chatRooms = snapshot.data as List<ChatRoom>?;
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: (snapshot.connectionState == ConnectionState.none ||
                      snapshot.connectionState == ConnectionState.waiting)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CupertinoActivityIndicator(
                          color: Color(0xFF1C3857),
                          radius: 10.0,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          "Connecting...",
                          style: GoogleFonts.balooPaaji2(
                            fontSize: 25.0,
                            color: const Color(0xFF1C3857),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      "Messages",
                      style: GoogleFonts.balooPaaji2(
                        fontSize: 25.0,
                        color: const Color(0xFF1C3857),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
            body: (snapshot.hasData)
                ? ListView.builder(
                    itemCount: chatRooms!.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return MessageTile(
                        user: user,
                        chatRoomId: chatRooms[index].chatRoomId,
                        professionalUID: chatRooms[index].professionalUID,
                      );
                    },
                  )
                : Container(),
          );
        },
      ),
    );
  }
}
