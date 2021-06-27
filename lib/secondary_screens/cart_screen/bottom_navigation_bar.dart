// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/constants/signature_button.dart';

class CartNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20.0,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder(
                stream: DatabaseService(uid: user.uid).cartServiceData,
                builder: (context, snapshot) {
                  int total = 0;
                  List<Help4YouCartServices> cartServices = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.active) {
                    for (Help4YouCartServices cartService in cartServices) {
                      total += cartService.servicePrice * cartService.quantity;
                    }
                  }
                  return Text(
                    "₹$total",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                    ),
                  );
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / (1792 / 1000),
                child: SignatureButton(
                  text: "Book Services",
                  icon: FluentIcons.arrow_right_24_regular,
                  onTap: () {
                    // TODO: Implement Booking Of Services
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
