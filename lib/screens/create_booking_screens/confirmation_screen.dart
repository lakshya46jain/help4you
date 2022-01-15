// Flutter Imports
import 'dart:async';
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:flare_flutter/flare_actor.dart';
import 'package:page_transition/page_transition.dart';
// File Imports
import 'package:help4you/screens/wrapper.dart';

class ConfirmationScreen extends StatefulWidget {
  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              child: FlareActor(
                "assets/flares/Success_Flare_Without_Loop.flr",
                alignment: Alignment.center,
                fit: BoxFit.fill,
                animation: 'Untitled',
              ),
            ),
            SizedBox(height: 25.0),
            Text(
              "Booking Confirmed",
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            Text(
              "Thank you for booking your services from Help4You. We hope to provide you an unforgettable experience.",
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF95989A).withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  startTime() async {
    var duration = Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        child: Wrapper(),
        type: PageTransitionType.fade,
      ),
      (route) => false,
    );
  }
}
