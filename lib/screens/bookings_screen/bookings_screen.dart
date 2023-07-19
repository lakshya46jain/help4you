// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
// File Imports
import 'package:help4you/screens/bookings_screen/components/body.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  BookingsScreenState createState() => BookingsScreenState();
}

class BookingsScreenState extends State<BookingsScreen> {
  int index = 0;
  String? bookingStatus;
  FixedExtentScrollController? scrollController;

  final items = [
    "Show All Bookings",
    "Booking Pending",
    "Accepted",
    "Completed Projects",
    "Completed Payments",
    "Rejected",
    "Customer Cancelled",
  ];

  void getPermission() async {
    var notificationStatus = await Permission.notification.status;
    if (notificationStatus.isDenied) {
      Permission.notification.request();
    } else if (notificationStatus.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  void initState() {
    getPermission();
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: index);
  }

  @override
  void dispose() {
    scrollController!.dispose();
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
          style: GoogleFonts.balooPaaji2(
            fontSize: 25.0,
            color: const Color(0xFF1C3857),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
              onPressed: () {
                scrollController!.dispose();
                scrollController =
                    FixedExtentScrollController(initialItem: index);
                final pickerOptions = SizedBox(
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
                          bookingStatus = "Accepted";
                        });
                      } else if (index == 3) {
                        setState(() {
                          bookingStatus = "Job Completed";
                        });
                      } else if (index == 4) {
                        setState(() {
                          bookingStatus = "Payment Completed";
                        });
                      } else if (index == 5) {
                        setState(() {
                          bookingStatus = "Rejected";
                        });
                      } else if (index == 6) {
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
                              style: const TextStyle(fontSize: 22.0),
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
              icon: const Icon(
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
