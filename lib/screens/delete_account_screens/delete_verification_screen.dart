// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:pinput/pinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
// File Imports
import 'package:help4you/services/auth.dart';
import 'package:help4you/constants/signature_button.dart';

class DeleteAccVerificationScreen extends StatefulWidget {
  final String phoneIsoCode;
  final String nonInternationalNumber;
  final String phoneNumber;
  final Function submitOTP;

  DeleteAccVerificationScreen({
    @required this.phoneIsoCode,
    @required this.nonInternationalNumber,
    @required this.phoneNumber,
    @required this.submitOTP,
  });

  @override
  _DeleteAccVerificationScreenState createState() =>
      _DeleteAccVerificationScreenState();
}

class _DeleteAccVerificationScreenState
    extends State<DeleteAccVerificationScreen> {
  // Text Field Variable
  String fullName;
  String phoneIsoCode;
  String nonInternationalNumber;

  // Pin Put Declarations
  Color borderColor = Color.fromRGBO(114, 178, 238, 1);

  final defaultPinTheme = PinTheme(
    width: 55,
    height: 60,
    textStyle: TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      color: Color.fromRGBO(222, 231, 240, .57),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.transparent),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: SignatureButton(type: "Back Button"),
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
                Pinput(
                  length: 6,
                  autofocus: true,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    width: 63,
                    height: 68,
                    decoration: defaultPinTheme.decoration.copyWith(
                      border: Border.all(color: borderColor),
                    ),
                  ),
                  onCompleted: widget.submitOTP,
                ),
                SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () async {
                    FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: widget.phoneNumber,
                      timeout: Duration(seconds: 120),
                      verificationCompleted:
                          (PhoneAuthCredential credential) async {},
                      verificationFailed:
                          (FirebaseAuthException exception) async {
                        AuthService().verificationFailed(
                          exception,
                          context,
                        );
                      },
                      codeSent:
                          (String verificationId, int resendToken) async {},
                      codeAutoRetrievalTimeout: (String verificationId) async {
                        verificationId = verificationId;
                      },
                    );
                  },
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
