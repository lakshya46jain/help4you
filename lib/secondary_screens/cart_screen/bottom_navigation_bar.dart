// Flutter Imports
import 'package:flutter/material.dart';
import 'package:help4you/secondary_screens/create_booking_screen/saved_address_screen.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/address_model.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/secondary_screens/create_booking_screen/add_address_screen.dart';

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: StreamBuilder(
              stream: DatabaseService(uid: user.uid).cartServiceListData,
              builder: (context, snapshot) {
                double total = 0;
                List<Help4YouCartServices> cartServices = snapshot.data;
                if (snapshot.connectionState == ConnectionState.active) {
                  for (Help4YouCartServices cartService in cartServices) {
                    total += cartService.servicePrice * cartService.quantity;
                  }
                }
                return Text(
                  "₹$total",
                  style: TextStyle(
                    fontSize: 28.0,
                    color: Color(0xFF1C3857),
                    fontFamily: "BalooPaaji",
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ),
          StreamBuilder(
            stream: DatabaseService(uid: user.uid).addressData,
            builder: (context, snapshot) {
              List<Address> addressData = snapshot.data;
              return GestureDetector(
                onTap: () {
                  if (snapshot.hasData) {
                    if (addressData.length == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddAddressScreen(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Make Booking",
                        style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.white,
                          fontFamily: "BalooPaaji",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        FluentIcons.arrow_circle_right_24_filled,
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
      ),
    );
  }
}
