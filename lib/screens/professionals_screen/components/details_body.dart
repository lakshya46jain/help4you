// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// File Imports
import 'package:help4you/screens/message_screen/messages_screen.dart';
import 'package:help4you/screens/professionals_screen/components/service_tile.dart';
import 'package:help4you/screens/professionals_screen/components/custom_media_button.dart';

class DetailsScreenBody extends StatelessWidget {
  final String profilePicture;
  final String fullName;
  final String occupation;
  final String phoneNumber;
  final String professionalUID;

  const DetailsScreenBody({
    Key key,
    @required this.profilePicture,
    @required this.fullName,
    @required this.occupation,
    @required this.phoneNumber,
    @required this.professionalUID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
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
                const SizedBox(width: 15.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      fullName,
                      style: const TextStyle(
                        color: Color(0xFF1C3857),
                        fontWeight: FontWeight.w800,
                        fontSize: 24.0,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      occupation,
                      style: const TextStyle(
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
            padding: const EdgeInsets.only(
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
                  icon: CupertinoIcons.phone_solid,
                  color: const Color(0xFF1C3857),
                  title: "Contact",
                ),
                CustomMediaButton(
                  onTap: () {},
                  icon: CupertinoIcons.book_fill,
                  color: const Color(0xFF1C3857),
                  title: "Rate Card",
                ),
                CustomMediaButton(
                  onTap: () {
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
                        ),
                      ),
                    );
                  },
                  icon: CupertinoIcons.chat_bubble_fill,
                  color: const Color(0xFF1C3857),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                    physics: const NeverScrollableScrollPhysics(),
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
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
