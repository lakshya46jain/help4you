// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/screens/cart_screen/components/continue_button_stream.dart';

class TotalValueWidget extends StatelessWidget {
  final Help4YouUser user;

  TotalValueWidget({
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
            ContinueButtonStream(
              user: user,
              cartServices: cartServices,
            ),
          ],
        );
      },
    );
  }
}
