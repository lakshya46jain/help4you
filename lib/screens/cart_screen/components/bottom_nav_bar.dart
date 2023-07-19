// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/screens/cart_screen/components/total_value_widget.dart';

class CartNavBar extends StatelessWidget {
  const CartNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser?>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20.0,
            color: const Color(0xFFDADADA).withOpacity(0.5),
          ),
        ],
      ),
      child: TotalValueWidget(
        user: user!,
      ),
    );
  }
}
