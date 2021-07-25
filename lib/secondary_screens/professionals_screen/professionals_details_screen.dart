// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// File Imports
import 'package:help4you/secondary_screens/message_screen/messages_screen.dart';
import 'package:help4you/secondary_screens/professionals_screen/app_bar.dart';
import 'package:help4you/secondary_screens/professionals_screen/custom_media_button.dart';
import 'package:help4you/secondary_screens/professionals_screen/service_tile_stream.dart';

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height / (1792 / 100),
          ),
          child: ProfessionalDetailAppBar(
            rating: rating,
          ),
        ),
        body: SingleChildScrollView(
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
                      icon: FluentIcons.chat_28_filled,
                      color: Color(0xFF1C3857),
                      title: "Message",
                    ),
                  ],
                ),
              ),
              ServiceTileBuilder(
                uid: professionalUID,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
