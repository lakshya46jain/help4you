// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/screens/cart_screen/components/bottom_nav_bar.dart';
import 'package:help4you/screens/cart_screen/components/cart_list_builder.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser?>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: const SignatureButton(type: "Back Button"),
        title: Text(
          "My Cart",
          style: GoogleFonts.balooPaaji2(
            fontSize: 25.0,
            color: const Color(0xFF1C3857),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: DatabaseService(uid: user!.uid).cartServiceListData,
        builder: (context, snapshot) {
          List<CartServices>? cartServices =
              snapshot.data as List<CartServices>?;
          if (snapshot.hasData) {
            if (cartServices!.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: SvgPicture.asset(
                      "assets/graphics/Help4You_Illustration_7.svg",
                    ),
                  ),
                ),
              );
            } else {
              return CartListBuilder(cartServices: cartServices);
            }
          } else {
            return Container();
          }
        },
      ),
      bottomNavigationBar: const CartNavBar(),
    );
  }
}
