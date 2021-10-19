// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/screens/cart_screen/cart_screen.dart';

class Header extends StatelessWidget {
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
      padding: EdgeInsets.all(20.0),
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
                    SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF95989A),
                            fontFamily: "BalooPaaji",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          userData.fullName,
                          style: TextStyle(
                            height: 1.0,
                            fontSize: 23.0,
                            color: Color(0xFF1C3857),
                            fontFamily: "BalooPaaji",
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
                    SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF95989A),
                            fontFamily: "BalooPaaji",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Full Name",
                          style: TextStyle(
                            height: 1.0,
                            fontSize: 23.0,
                            color: Color(0xFF1C3857),
                            fontFamily: "BalooPaaji",
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
          StreamBuilder(
            stream: DatabaseService(uid: user.uid).cartServiceListData,
            builder: (context, snapshot) {
              int totalItems = 0;
              List<CartServices> cartServices = snapshot.data;
              if (snapshot.connectionState == ConnectionState.active) {
                for (CartServices cartService in cartServices) {
                  totalItems += cartService.quantity;
                }
              }
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF1C3857),
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "$totalItems",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "BalooPaaji",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
