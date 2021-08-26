// Flutter Imports
import 'dart:async';
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/primary_screens/wrapper.dart';

class BookingConfirmedScreen extends StatefulWidget {
  @override
  _BookingConfirmedScreenState createState() => _BookingConfirmedScreenState();
}

class _BookingConfirmedScreenState extends State<BookingConfirmedScreen> {
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
      backgroundColor: Color(0xFF1C3857),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFEA700),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    FluentIcons.checkmark_28_filled,
                    size: MediaQuery.of(context).size.width * 0.3,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              "Booking Confirmed",
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  startTime() async {
    var duration = Duration(seconds: 1);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Wrapper(),
      ),
      (route) => false,
    );
  }
}
