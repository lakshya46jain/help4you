// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/constants/signature_button.dart';

class CartNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13.0,
                    ),
                  ),
                  Text(
                    // TODO: Update Price According To The Value of Items In Cart
                    "\$500.55",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ],
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
