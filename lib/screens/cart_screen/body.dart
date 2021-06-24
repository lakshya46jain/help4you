// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/screens/cart_screen/cart_service_tile.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    // Get User UID
    final user = Provider.of<Help4YouUser>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: StreamBuilder(
        stream: DatabaseService(uid: user.uid).cartServiceData,
        builder: (context, snapshot) {
          List<Help4YouCartServices> cartServices = snapshot.data;
          if (cartServices.length == 0) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / (1792 / 600),
                  child: SvgPicture.asset(
                    "assets/graphics/Help4You_Illustration_6.svg",
                  ),
                ),
                Text(
                  "Oops! Looks like your cart is empty",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: cartServices.length,
              itemBuilder: (context, index) {
                return CartServiceTile(
                  serviceId: cartServices[index].serviceId,
                  professionalId: cartServices[index].professionalId,
                  serviceTitle: cartServices[index].serviceTitle,
                  serviceDescription: cartServices[index].serviceDescription,
                  servicePrice: cartServices[index].servicePrice,
                  quantity: cartServices[index].quantity,
                );
              },
            );
          }
        },
      ),
    );
  }
}
