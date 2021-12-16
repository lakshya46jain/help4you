// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/address_model.dart';
import 'package:help4you/constants/custom_snackbar.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/screens/create_booking_screen/new_address_screen.dart';
import 'package:help4you/screens/create_booking_screen/saved_address_screen.dart';

class CartNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20.0,
            color: Color(0xFFDADADA).withOpacity(0.5),
          ),
        ],
      ),
      child: StreamBuilder(
        stream: DatabaseService(uid: user.uid).cartServiceListData,
        builder: (context, snapshot) {
          double total = 0;
          List<CartServices> cartServices = snapshot.data;
          if (snapshot.connectionState == ConnectionState.active) {
            for (CartServices cartService in cartServices) {
              total += cartService.servicePrice * cartService.quantity;
            }
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "$total",
                  style: TextStyle(
                    fontSize: 28.0,
                    color: Color(0xFF1C3857),
                    fontFamily: "BalooPaaji",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              StreamBuilder(
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
              ),
            ],
          );
        },
      ),
    );
  }
}
