// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/screens/cart_screen/cart_screen.dart';

class CartButtonStream extends StatelessWidget {
  final Help4YouUser user;

  CartButtonStream({
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
    );
  }
}
