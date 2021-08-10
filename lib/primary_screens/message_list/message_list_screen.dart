// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/constants/loading.dart';
import 'package:help4you/models/chat_room_model.dart';
import 'package:help4you/constants/custom_search_bar.dart';
import 'package:help4you/primary_screens/message_list/message_tile.dart';

class MessageListScreen extends StatefulWidget {
  @override
  _MessageListScreenState createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  // Search Controller
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Messages",
            style: TextStyle(
              fontSize: 25.0,
              color: Color(0xFF1C3857),
              fontFamily: "BalooPaaji",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 5.0,
            ),
            SearchBar(
              width: MediaQuery.of(context).size.width,
              hintText: "Search messages...",
              controller: searchController,
            ),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: StreamBuilder(
                stream: DatabaseService(uid: user.uid).chatRoomsData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ChatRoom> chatRooms = snapshot.data;
                    return ListView.builder(
                      itemCount: chatRooms.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return MessageTile(
                          uid: chatRooms[index].professionalUID,
                          chatRoomId: chatRooms[index].chatRoomId,
                        );
                      },
                    );
                  } else {
                    return DoubleBounceLoading();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
