// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/screens/home_screen/components/cart_button_stream.dart';

class Header extends StatelessWidget {
  const Header({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    // Key Variables
    var message = '';
    var currentTime = int.parse(
      DateFormat('kk').format(
        DateTime.now(),
      ),
    );

    // Message Updating
    if (currentTime <= 12) {
      message = 'Good Morning ⛅️';
    } else if ((currentTime > 12) && (currentTime <= 16)) {
      message = 'Good Afternoon 🌤';
    } else if ((currentTime > 16) && (currentTime < 20)) {
      message = 'Good Evening 🌇';
    } else {
      message = 'Good Night 🌙';
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              UserDataCustomer userData = snapshot.data;
              if (snapshot.hasData) {
                return Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        height: 60,
                        width: 60,
                        imageUrl: userData.profilePicture,
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message,
                          style: GoogleFonts.balooPaaji2(
                            fontSize: 18.0,
                            color: const Color(0xFF95989A),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          userData.fullName,
                          style: GoogleFonts.balooPaaji2(
                            height: 1.0,
                            fontSize: 23.0,
                            color: const Color(0xFF1C3857),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        height: 60,
                        width: 60,
                        imageUrl:
                            "https://drive.google.com/uc?export=view&id=1Fis4yJe7_d_RROY7JdSihM2--GH5aqbe",
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message,
                          style: GoogleFonts.balooPaaji2(
                            fontSize: 18.0,
                            color: const Color(0xFF95989A),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Full Name",
                          style: GoogleFonts.balooPaaji2(
                            height: 1.0,
                            fontSize: 23.0,
                            color: const Color(0xFF1C3857),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
          CartButtonStream(
            user: user,
          ),
        ],
      ),
    );
  }
}
