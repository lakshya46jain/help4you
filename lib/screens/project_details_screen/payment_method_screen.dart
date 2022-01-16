// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:page_transition/page_transition.dart';
// File Imports
import 'package:help4you/services/database.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/screens/create_booking_screens/confirmation_screen.dart';

class PaymentMethodScreen extends StatefulWidget {
  final String bookingId;

  PaymentMethodScreen({
    @required this.bookingId,
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  // Selected Index
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: SignatureButton(type: "Back Button"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Payment methods",
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  "Please choose your desired method of payment to the professional.",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 25.0),
                Text(
                  "Cash Payment",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF95989A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(9.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: (selectedIndex == 0)
                          ? Border.all(color: Color(0xFFFEA700))
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: (selectedIndex != 0)
                              ? Color(0xFF95989A).withOpacity(0.4)
                              : Colors.transparent,
                          offset: Offset(0, 5),
                          blurRadius: 5.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 75.0,
                              height: 75.0,
                              color: Color(0xFF1C3857),
                            ),
                            SizedBox(width: 15.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cash payment",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  "Popular method",
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Color(0xFF95989A).withOpacity(0.75),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        (selectedIndex == 0)
                            ? Icon(
                                CupertinoIcons.checkmark_square_fill,
                                color: Color(0xFFFEA700),
                                size: 30.0,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            (selectedIndex != null)
                ? SafeArea(
                    child: Column(
                      children: [
                        SignatureButton(
                          onTap: () async {
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                child: ConfirmationScreen(
                                  title: "Payment Completed",
                                  description:
                                      "Thank you for choosing Help4You! We hope the service delivered to you provided you with an impeccable experience.",
                                ),
                                type: PageTransitionType.fade,
                              ),
                              (route) => false,
                            );
                            await DatabaseService(bookingId: widget.bookingId)
                                .updateBookingStatus("Payment Completed");
                            if (selectedIndex == 0) {
                              await DatabaseService(bookingId: widget.bookingId)
                                  .updatePaymentMethod(0);
                            } else {
                              await DatabaseService(bookingId: widget.bookingId)
                                  .updatePaymentMethod(1);
                            }
                          },
                          text: "Continue",
                          withIcon: false,
                          type: "Yellow",
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
