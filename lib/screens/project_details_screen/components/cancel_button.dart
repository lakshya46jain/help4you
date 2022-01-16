// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:awesome_dialog/awesome_dialog.dart';
// File Imports
import 'package:help4you/services/database.dart';

class CancelButton extends StatelessWidget {
  final String bookingId;

  CancelButton({
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
      onPressed: () {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.WARNING,
          title: "Warning!",
          desc:
              "Do you want to continue cancelling your booking? Note: This action is not reversible.",
          btnOkText: "Yes",
          btnCancelText: "No",
          btnOkOnPress: () async {
            Navigator.pop(context);
            await DatabaseService(bookingId: bookingId)
                .updateBookingStatus("Customer Cancelled");
          },
          btnCancelOnPress: () => Navigator.pop(context),
        ).show();
      },
      color: Colors.red,
      child: Text(
        "Cancel Project",
        style: TextStyle(
          fontSize: 17.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
