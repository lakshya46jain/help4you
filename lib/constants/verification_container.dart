// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:pinput/pin_put/pin_put.dart';
// File Imports

class VerificationContainer extends StatelessWidget {
  final String text1;
  final String text2;
  final Function onSubmit;

  VerificationContainer({
    this.text1,
    this.text2,
    this.onSubmit,
  });

  final _pinPutFocusNode = FocusNode();
  final _pinPutController = TextEditingController();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    border: Border.all(color: Color(0xFF95989A)),
    borderRadius: BorderRadius.circular(15.0),
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "OTP Verification",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                text1,
                style: TextStyle(
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 2.0,
              ),
              Text(
                text2,
                style: TextStyle(
                  color: Color(0xFF95989A),
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "This code will expire in ",
                    style: TextStyle(
                      color: Color(0xFF95989A),
                    ),
                  ),
                  TweenAnimationBuilder(
                    tween: Tween(
                      begin: 60.0,
                      end: 0.0,
                    ),
                    duration: Duration(
                      seconds: 60,
                    ),
                    builder: (
                      context,
                      value,
                      child,
                    ) =>
                        Text(
                      "00:${value.toInt()}",
                      style: TextStyle(
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              PinPut(
                fieldsCount: 6,
                textStyle: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                ),
                eachFieldWidth: 40,
                eachFieldHeight: 50,
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                submittedFieldDecoration: pinPutDecoration,
                followingFieldDecoration: pinPutDecoration,
                selectedFieldDecoration: pinPutDecoration,
                pinAnimationType: PinAnimationType.fade,
                onSubmit: onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
