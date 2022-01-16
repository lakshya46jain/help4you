// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/services/database.dart';

class MakePaymentButton extends StatelessWidget {
  final String bookingId;

  MakePaymentButton({
    @required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 30.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      onPressed: () async {
        Navigator.pop(context);
        await DatabaseService(bookingId: bookingId)
            .updateBookingStatus("Payment Completed");
        await DatabaseService(bookingId: bookingId)
            .updatePaymentMethod(0.toInt());
      },
      color: Colors.green,
      child: Text(
        "Make Payment",
        style: TextStyle(
          fontSize: 17.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
