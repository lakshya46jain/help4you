// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// File Imports
import 'package:help4you/services/database.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/constants/loading.dart';
import 'package:help4you/secondary_screens/professionals_screen/app_bar.dart';
import 'package:help4you/secondary_screens/message_screen/messages_screen.dart';
import 'package:help4you/secondary_screens/professionals_screen/service_tile.dart';
import 'package:help4you/secondary_screens/professionals_screen/custom_media_button.dart';

class ProfessionalsDetailsScreen extends StatelessWidget {
  final String professionalUID;
  final String profilePicture;
  final String fullName;
  final String occupation;
  final String phoneNumber;
  final int rating;

  ProfessionalsDetailsScreen({
    @required this.professionalUID,
    @required this.profilePicture,
    @required this.fullName,
    @required this.occupation,
    @required this.phoneNumber,
    @required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height / (1792 / 100),
        ),
        child: ProfessionalDetailAppBar(
          rating: rating,
          professionalUID: professionalUID,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Row(
                children: [
                  Container(
                    height: 125.0,
                    width: 125.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: CachedNetworkImage(
                        imageUrl: profilePicture,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        fullName,
                        style: TextStyle(
                          color: Color(0xFF1C3857),
                          fontWeight: FontWeight.w800,
                          fontSize: 24.0,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        occupation,
                        style: TextStyle(
                          color: Color(0xFF95989A),
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 5.0,
                bottom: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomMediaButton(
                    onTap: () {
                      FlutterPhoneDirectCaller.callNumber(
                        phoneNumber,
                      );
                    },
                    icon: FluentIcons.call_28_filled,
                    color: Color(0xFF1C3857),
                    title: "Contact",
                  ),
                  CustomMediaButton(
                    onTap: () {},
                    icon: FluentIcons.book_coins_24_filled,
                    color: Color(0xFF1C3857),
                    title: "Rate Card",
                  ),
                  CustomMediaButton(
                    onTap: () {
                      // Get Chat Room ID Function
                      getChatRoomId(String a, String b) {
                        if (a.substring(0, 1).codeUnitAt(0) >
                            b.substring(0, 1).codeUnitAt(0)) {
                          return "$b\_$a";
                        } else {
                          return "$a\_$b";
                        }
                      }

                      // Store Chat Room ID
                      String chatRoomId =
                          getChatRoomId(user.uid, professionalUID);

                      // Create Chat Room In Database
                      DatabaseService(chatRoomId: chatRoomId).createChatRoom(
                        user.uid,
                        professionalUID,
                      );

                      // Navigate To Message Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessageScreen(
                            uid: professionalUID,
                            fullName: fullName,
                            occupation: occupation,
                            phoneNumber: phoneNumber,
                            profilePicture: profilePicture,
                            chatRoomId: chatRoomId,
                          ),
                        ),
                      );
                    },
                    icon: FluentIcons.chat_28_filled,
                    color: Color(0xFF1C3857),
                    title: "Message",
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("H4Y Services Database")
                  .where("Professional UID", isEqualTo: professionalUID)
                  .where("Visibility", isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length == 0) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.61,
                        child: SvgPicture.asset(
                          "assets/graphics/Help4You_Illustration_6.svg",
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data.docs[index];
                        return ServiceTiles(
                          professionalId: professionalUID,
                          serviceId: documentSnapshot.id,
                          serviceTitle: documentSnapshot["Service Title"],
                          serviceDescription:
                              documentSnapshot["Service Description"],
                          servicePrice: documentSnapshot["Service Price"],
                        );
                      },
                    );
                  }
                } else {
                  return DoubleBounceLoading();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
