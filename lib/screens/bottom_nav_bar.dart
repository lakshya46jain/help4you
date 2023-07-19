// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
// Dependency Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/services/database.dart';
import 'package:help4you/screens/home_screen/home_screen.dart';
import 'package:help4you/screens/profile_screen/profile_screen.dart';
import 'package:help4you/screens/message_screen/messages_screen.dart';
import 'package:help4you/screens/bookings_screen/bookings_screen.dart';
import 'package:help4you/screens/message_list_screen/message_list_screen.dart';
import 'package:help4you/screens/project_details_screen/project_details_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar>
    with WidgetsBindingObserver {
  // Selected Index
  int selectedIndex = 0;

  // Tab Bar Tabs
  final tabs = [
    const HomeScreen(),
    const BookingsScreen(),
    const MessageListScreen(),
    const ProfileScreen(),
  ];

  // Current Index Tap
  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    notificationOpenHandler();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> notificationOpenHandler() async {
    OneSignal.shared.setNotificationOpenedHandler((openedResult) {
      String notifType =
          openedResult.notification.additionalData!['Notification Type'];
      String documentId =
          openedResult.notification.additionalData!['Document ID'];
      SchedulerBinding.instance.addPostFrameCallback((_) {
        final user = FirebaseAuth.instance.currentUser!.uid;
        String professionalUID = documentId.replaceAll("${user}_", "");
        if (notifType == "Message" && documentId != "") {
          FirebaseFirestore.instance
              .collection("H4Y Users Database")
              .doc(professionalUID)
              .get()
              .then((value) {
            String profilePicture = value.data()!["Profile Picture"];
            String fullName = value.data()!["Full Name"];
            String occupation = value.data()!["Occupation"];
            String phoneNumber = value.data()!["Phone Number"];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessageScreen(
                  uid: professionalUID,
                  profilePicture: profilePicture,
                  fullName: fullName,
                  occupation: occupation,
                  phoneNumber: phoneNumber,
                ),
              ),
            );
          });
        } else {
          FirebaseFirestore.instance
              .collection("H4Y Bookings Database")
              .doc(documentId)
              .get()
              .then((value) {
            int paymentMethodData = value.data()!["Payment Method"];
            String otp = value.data()!["One Time Password"];
            String address = value.data()!["Address"];
            double totalPrice = value.data()!["Total Price"];
            String bookingStatus = value.data()!["Booking Status"];
            Timestamp preferredTimings = value.data()!["Preferred Timings"];
            List<CartServices> bookedItems = [];
            List<dynamic> bookedItemsMap = value.data()!["Booked Items"];
            for (var element in bookedItemsMap) {
              bookedItems.add(
                CartServices(
                  serviceTitle: element["Title"],
                  serviceDescription: element["Description"],
                  servicePrice: element["Price"],
                  quantity: element["Quantity"],
                ),
              );
            }
            String paymentMethod = (paymentMethodData == 0)
                ? "Cash Payment"
                : (paymentMethodData == 1)
                    ? "Online Payment"
                    : (paymentMethodData == 2)
                        ? "Payment Incomplete"
                        : "";
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProjectDetailsScreen(
                  otp: otp,
                  uid: user,
                  address: address,
                  bookingId: documentId,
                  totalPrice: totalPrice,
                  bookingStatus: bookingStatus,
                  preferredTimings: preferredTimings,
                  bookedItemsList: bookedItems,
                  paymentMethod: paymentMethod,
                ),
              ),
            );
          });
        }
      });
    });
  }

  void setStatus(String status) {
    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .updateUserStatus(status);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus("Online");
    } else {
      setStatus("Offline");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          tabs[selectedIndex],
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
              ),
              child: BottomNavigationBar(
                onTap: onTap,
                elevation: 0.0,
                iconSize: 27.0,
                selectedFontSize: 1.0,
                unselectedFontSize: 1.0,
                currentIndex: selectedIndex,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: const Color(0xFF1C3857),
                unselectedItemColor: const Color(0xFF1C3857),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(FluentIcons.home_24_regular),
                    activeIcon: Icon(FluentIcons.home_24_filled),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.doc_text),
                    activeIcon: Icon(CupertinoIcons.doc_text_fill),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.chat_bubble),
                    activeIcon: Icon(CupertinoIcons.chat_bubble_fill),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FluentIcons.person_24_regular),
                    activeIcon: Icon(FluentIcons.person_24_filled),
                    label: "",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
