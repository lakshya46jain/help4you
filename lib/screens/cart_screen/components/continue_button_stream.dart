// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/address_model.dart';
import 'package:help4you/constants/custom_snackbar.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/screens/create_booking_screens/new_address_screen.dart';
import 'package:help4you/screens/create_booking_screens/saved_address_screen.dart';

class ContinueButtonStream extends StatelessWidget {
  final Help4YouUser user;
  final List<CartServices> cartServices;

  ContinueButtonStream({
    @required this.user,
    @required this.cartServices,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).addressListData,
      builder: (context, snapshot) {
        List<Address> addressData = snapshot.data;
        return GestureDetector(
          onTap: () {
            if (cartServices.length != 0) {
              if (snapshot.hasData) {
                if (addressData.length == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewAddressScreen(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SavedAddressScreen(),
                    ),
                  );
                }
              }
            } else {
              showCustomSnackBar(
                context,
                CupertinoIcons.exclamationmark_triangle,
                Colors.orange,
                "Warning!",
                "You cannot create a booking with an empty cart.",
              );
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            height: MediaQuery.of(context).size.height * 0.13,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              color: Color(0xFF1C3857),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.white,
                    fontFamily: "BalooPaaji",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 5.0),
                Icon(
                  CupertinoIcons.chevron_right,
                  color: Colors.white,
                  size: 28.0,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
