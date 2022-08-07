// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:google_fonts/google_fonts.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/address_model.dart';
import 'package:help4you/constants/custom_snackbar.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/screens/unique_users_screen/unique_users_screen.dart';
import 'package:help4you/screens/create_booking_screens/new_address_screen.dart';
import 'package:help4you/screens/create_booking_screens/saved_address_screen.dart';

class ContinueButtonStream extends StatelessWidget {
  final Help4YouUser user;
  final List<CartServices> cartServices;

  const ContinueButtonStream({
    Key key,
    @required this.user,
    @required this.cartServices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).addressListData,
      builder: (context, snapshot) {
        List<Address> addressData = snapshot.data;
        return GestureDetector(
          onTap: () {
            if (cartServices.isNotEmpty) {
              Set<String> uniqueUsers = {};
              for (CartServices cartService in cartServices) {
                uniqueUsers.add(cartService.professionalId);
              }
              if (uniqueUsers.length != 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UniqueUsersScreen(
                      uniqueUsers: uniqueUsers,
                    ),
                  ),
                );
              } else {
                if (addressData.isEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewAddressScreen(
                        professionalUID: uniqueUsers.elementAt(0),
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SavedAddressScreen(
                        professionalUID: uniqueUsers.elementAt(0),
                      ),
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            height: MediaQuery.of(context).size.height * 0.13,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: const BoxDecoration(
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
                  style: GoogleFonts.balooPaaji2(
                    fontSize: 28.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 5.0),
                const Icon(
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
