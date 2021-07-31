// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:pinput/pin_put/pin_put.dart';
// File Imports
import 'package:help4you/constants/back_button.dart';

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final Function submitOTP;
  final Function resendOTP;

  VerificationScreen({
    @required this.phoneNumber,
    @required this.submitOTP,
    this.resendOTP,
  });

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  // Text Field Variable
  String fullName;
  String phoneIsoCode;
  String nonInternationalNumber;

  // Pin Input Declarations
  final _pinPutFocusNode = FocusNode();
  final _pinPutController = TextEditingController();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    border: Border.all(
      color: Color(0xFF95989A),
    ),
    borderRadius: BorderRadius.circular(15.0),
  );
  final BoxDecoration pinPutSelectedDecoration = BoxDecoration(
    border: Border.all(
      color: Color(0xFF1C3857),
    ),
    borderRadius: BorderRadius.circular(15.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: CustomBackButton(),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Enter the 6-digit OTP sent to",
                    style: TextStyle(
                      height: 1.0,
                      fontSize: 24.0,
                      color: Colors.black,
                      fontFamily: "BalooPaaji",
                      fontWeight: FontWeight.normal,
                    ),
                    children: [
                      TextSpan(
                        text: "\n${widget.phoneNumber}",
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 24.0,
                          color: Colors.black,
                          fontFamily: "BalooPaaji",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                PinPut(
                  autofocus: true,
                  fieldsCount: 6,
                  textStyle: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                  eachFieldWidth: 55,
                  eachFieldHeight: 60,
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  submittedFieldDecoration: pinPutDecoration,
                  followingFieldDecoration: pinPutDecoration,
                  selectedFieldDecoration: pinPutSelectedDecoration,
                  pinAnimationType: PinAnimationType.fade,
                  onSubmit: widget.submitOTP,
                ),
                SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () async {},
                  child: Text.rich(
                    TextSpan(
                      text: "Didn't recieve the OTP?",
                      style: TextStyle(
                        height: 1.0,
                        fontSize: 16.0,
                        color: Colors.black45,
                        fontFamily: "BalooPaaji",
                        fontWeight: FontWeight.normal,
                      ),
                      children: [
                        TextSpan(
                          text: " Resend",
                          style: TextStyle(
                            height: 1.3,
                            fontSize: 16.0,
                            color: Color(0xFF1C3857),
                            fontFamily: "BalooPaaji",
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
