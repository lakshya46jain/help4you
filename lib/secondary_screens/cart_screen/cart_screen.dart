// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/constants/loading.dart';
import 'package:help4you/constants/back_button.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/secondary_screens/cart_screen/cart_service_tile.dart';
import 'package:help4you/secondary_screens/cart_screen/bottom_navigation_bar.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: CustomBackButton(),
        title: Text(
          "My Cart",
          style: TextStyle(
            fontSize: 25.0,
            color: Color(0xFF1C3857),
            fontFamily: "BalooPaaji",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: StreamBuilder(
          stream: DatabaseService(uid: user.uid).cartServiceData,
          builder: (context, snapshot) {
            List<Help4YouCartServices> cartServices = snapshot.data;
            if (snapshot.hasData) {
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
                        fontSize: 20.0,
                        fontFamily: "BalooPaaji",
                        color: Color(0xFF1C3857),
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
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CartServiceTile(
                      serviceId: cartServices[index].serviceId,
                      professionalId: cartServices[index].professionalId,
                      serviceTitle: cartServices[index].serviceTitle,
                      serviceDescription:
                          cartServices[index].serviceDescription,
                      servicePrice: cartServices[index].servicePrice,
                      quantity: cartServices[index].quantity,
                    );
                  },
                );
              }
            } else {
              return DoubleBounceLoading();
            }
          },
        ),
      ),
      bottomNavigationBar: CartNavBar(),
    );
  }
}
