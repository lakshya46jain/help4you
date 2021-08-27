// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/screens/cart_screen/components/cart_service_tile.dart';

class CartListBuilder extends StatelessWidget {
  final List<Help4YouCartServices> cartServices;

  CartListBuilder({
    @required this.cartServices,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cartServices.length,
      padding: EdgeInsets.all(0.0),
      physics: BouncingScrollPhysics(),
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
}
