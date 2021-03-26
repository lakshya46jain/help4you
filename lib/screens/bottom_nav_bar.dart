// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:ant_icons/ant_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// File Imports
import 'package:help4you/screens/home_screen/home_screen.dart';
import 'package:help4you/screens/settings_screen/settings_screen.dart';
import 'package:help4you/screens/bookings_screen/bookings_screen.dart';
import 'package:help4you/screens/message_list_screen/message_list_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // Selected Index
  int selectedIndex = 0;

  // Tab Bar Tabs
  final tabs = [
    HomeScreen(),
    BookingsScreen(),
    MessageListScreen(),
    SettingsScreens(),
  ];

  // Current Index Tap
  void onTap(int index) {
    setState(
      () {
        selectedIndex = index;
      },
    );
  }

  // Google Nav Bar Variables
  double gap = 10.0;
  double iconSize = 24.0;
  Color inactiveColor = Colors.black;
  Color mainColor = Colors.deepOrangeAccent;
  Color backgroundColor = Colors.deepOrangeAccent.withOpacity(0.15);
  var padding = EdgeInsets.symmetric(horizontal: 18, vertical: 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
            child: GNav(
              onTabChange: onTap,
              tabs: [
                GButton(
                  icon: AntIcons.home_outline,
                  text: 'Home',
                  gap: gap,
                  iconActiveColor: mainColor,
                  iconColor: inactiveColor,
                  textColor: mainColor,
                  backgroundColor: backgroundColor,
                  iconSize: iconSize,
                  padding: padding,
                ),
                GButton(
                  icon: AntIcons.solution,
                  text: 'Bookings',
                  gap: gap,
                  iconActiveColor: mainColor,
                  iconColor: inactiveColor,
                  textColor: mainColor,
                  backgroundColor: backgroundColor,
                  iconSize: iconSize,
                  padding: padding,
                ),
                GButton(
                  icon: AntIcons.message_outline,
                  text: 'Messages',
                  gap: gap,
                  iconActiveColor: mainColor,
                  iconColor: inactiveColor,
                  textColor: mainColor,
                  backgroundColor: backgroundColor,
                  iconSize: iconSize,
                  padding: padding,
                ),
                GButton(
                  icon: AntIcons.setting_outline,
                  text: 'Settings',
                  gap: gap,
                  iconActiveColor: mainColor,
                  iconColor: inactiveColor,
                  textColor: mainColor,
                  backgroundColor: backgroundColor,
                  iconSize: iconSize,
                  padding: padding,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
