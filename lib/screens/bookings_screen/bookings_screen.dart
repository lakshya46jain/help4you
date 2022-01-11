// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
// File Imports
import 'package:help4you/screens/bookings_screen/components/body.dart';

class BookingsScreen extends StatefulWidget {
  @override
  _BookingsScreenState createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  int index = 0;
  String bookingStatus;
  FixedExtentScrollController scrollController;

  final items = [
    "Show All Bookings",
    "Booking Pending",
    "Job Completed",
    "Accepted",
    "Rejected",
    "Customer Cancelled",
  ];

  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: index);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Booking",
          style: TextStyle(
            fontSize: 25.0,
            color: Color(0xFF1C3857),
            fontFamily: "BalooPaaji",
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: IconButton(
              onPressed: () {
                scrollController.dispose();
                scrollController =
                    FixedExtentScrollController(initialItem: index);
                final pickerOptions = Container(
                  height: 225.0,
                  child: CupertinoPicker(
                    scrollController: scrollController,
                    itemExtent: 54,
                    onSelectedItemChanged: (index) {
                      HapticFeedback.lightImpact();
                      setState(() => this.index = index);
                      if (index == 0) {
                        setState(() {
                          bookingStatus = null;
                        });
                      } else if (index == 1) {
                        setState(() {
                          bookingStatus = "Booking Pending";
                        });
                      } else if (index == 2) {
                        setState(() {
                          bookingStatus = "Job Completed";
                        });
                      } else if (index == 3) {
                        setState(() {
                          bookingStatus = "Accepted";
                        });
                      } else if (index == 4) {
                        setState(() {
                          bookingStatus = "Rejected";
                        });
                      } else if (index == 5) {
                        setState(() {
                          bookingStatus = "Customer Cancelled";
                        });
                      }
                    },
                    children: items
                        .map(
                          (item) => Center(
                            child: Text(
                              item,
                              style: TextStyle(fontSize: 22.0),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => pickerOptions,
                );
              },
              icon: Icon(
                CupertinoIcons.line_horizontal_3_decrease,
                color: Color(0xFF1C3857),
              ),
            ),
          ),
        ],
      ),
      body: BookingsScreenBody(
        bookingStatus: bookingStatus,
      ),
    );
  }
}
