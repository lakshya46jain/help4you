// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/messages_model.dart';
import 'package:help4you/screens/message_screen/messages_screen.dart';

class MessageTile extends StatelessWidget {
  final Help4YouUser user;
  final String chatRoomId;
  final String professionalUID;

  MessageTile({
    @required this.user,
    @required this.chatRoomId,
    @required this.professionalUID,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("H4Y Users Database")
          .doc(professionalUID)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Professional Data Strings
          String profilePicture = snapshot.data["Profile Picture"];
          String fullName = snapshot.data["Full Name"];
          String phoneNumber = snapshot.data["Phone Number"];
          String occupation = snapshot.data["Occupation"];
          String status = snapshot.data["Status"];

          // Message Tile
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessageScreen(
                    uid: professionalUID,
                    profilePicture: profilePicture,
                    fullName: fullName,
                    phoneNumber: phoneNumber,
                    occupation: occupation,
                  ),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xFFF5F6F9),
                        backgroundImage: CachedNetworkImageProvider(
                          profilePicture,
                        ),
                      ),
                      (status == "Online")
                          ? Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                  color: Color(0xFF00BF6D),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              height: 0.0,
                              width: 0.0,
                            ),
                    ],
                  ),
                  StreamBuilder(
                    stream: DatabaseService(
                      uid: user.uid,
                      professionalUID: professionalUID,
                    ).lastMessageData,
                    builder: (context, snapshot) {
                      List<Messages> messages = snapshot.data;
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      fullName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Color(0xFF1C3857),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Opacity(
                                    opacity: 0.5,
                                    child: Text(
                                      (snapshot.hasData && messages.length != 0)
                                          ? "${DateFormat('dd/MM/yy').format(messages[0].timeStamp.toDate().toLocal())}"
                                          : "",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("H4Y Chat Rooms Database")
                                    .doc(chatRoomId)
                                    .collection("Messages")
                                    .where("Is Read", isEqualTo: false)
                                    .where(
                                      "Sender",
                                      isEqualTo: professionalUID,
                                    )
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  int unreadLength = snapshot.data.docs.length;
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: Opacity(
                                          opacity: 0.5,
                                          child: (snapshot.hasData &&
                                                  messages.length != 0)
                                              ? Text(
                                                  (messages[0].type ==
                                                              "Media" &&
                                                          messages[0].sender ==
                                                              user.uid)
                                                      ? "You: Sent a photo\n"
                                                      : (messages[0].type ==
                                                                  "Media" &&
                                                              messages[0]
                                                                      .sender !=
                                                                  user.uid)
                                                          ? "Sent a photo\n"
                                                          : (messages[0]
                                                                      .sender ==
                                                                  user.uid)
                                                              ? "You: ${messages[0].message}\n"
                                                              : "${messages[0].message}\n",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                  ),
                                                )
                                              : Text(
                                                  "\n\n",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: (unreadLength != 0) ? 10.0 : 0.0,
                                      ),
                                      (unreadLength != 0)
                                          ? ConstrainedBox(
                                              constraints: BoxConstraints(
                                                minWidth: 20.0,
                                                maxWidth: 50.0,
                                              ),
                                              child: Container(
                                                padding: EdgeInsets.all(3.5),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF1C3857),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                ),
                                                child: Center(
                                                  widthFactor: 2.0,
                                                  child: Text(
                                                    (unreadLength > 99)
                                                        ? "99+"
                                                        : snapshot.data.docs
                                                                .length >
                                                            99.toString(),
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  );
                                },
                              ),
                              SizedBox(height: 5.0),
                              Divider(
                                thickness: 1.5,
                                color: Color(0xFF95989A).withOpacity(0.2),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
