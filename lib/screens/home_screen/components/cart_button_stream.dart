// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:google_fonts/google_fonts.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/screens/cart_screen/cart_screen.dart';

class CartButtonStream extends StatelessWidget {
  final Help4YouUser? user;

  const CartButtonStream({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService(uid: user!.uid).cartServiceListData,
      builder: (context, snapshot) {
        int totalItems = 0;
        List<CartServices>? cartServices = snapshot.data as List<CartServices>?;
        if (snapshot.connectionState == ConnectionState.active) {
          for (CartServices cartService in cartServices!) {
            totalItems += cartService.quantity!;
          }
        }
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ),
            );
          },
          child: Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: const Color(0xFF1C3857),
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
            child: Center(
              child: Text(
                "$totalItems",
                style: GoogleFonts.balooPaaji2(
                  fontSize: 20.0,
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
