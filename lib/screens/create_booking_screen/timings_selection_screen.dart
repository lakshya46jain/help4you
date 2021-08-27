// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/constants/back_button.dart';
import 'package:help4you/screens/create_booking_screen/components/time_picker.dart';
import 'package:help4you/screens/create_booking_screen/components/timings_footer.dart';

class TimingsSelectionScreen extends StatefulWidget {
  final String completeAddress;
  final GeoPoint geoPointLocation;

  TimingsSelectionScreen({
    this.completeAddress,
    this.geoPointLocation,
  });

  @override
  _TimingsSelectionScreenState createState() => _TimingsSelectionScreenState();
}

class _TimingsSelectionScreenState extends State<TimingsSelectionScreen> {
  // Calendar Variables
  DateTime focusedDay = DateTime.now();

  DateTime firstDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime lastDay = DateTime.utc(
    DateTime.now().year + 1,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: CustomBackButton(),
        title: Text(
          "Select Timings",
          style: TextStyle(
            fontSize: 25.0,
            color: Color(0xFF1C3857),
            fontFamily: "BalooPaaji",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 20.0,
                  bottom: 10.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: Text(
                  "Pick Date",
                  style: TextStyle(
                    fontSize: 23.0,
                    color: Color(0xFF1C3857),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: TableCalendar(
                  firstDay: firstDay,
                  lastDay: lastDay,
                  focusedDay: focusedDay,
                  calendarFormat: CalendarFormat.week,
                  availableCalendarFormats: {
                    CalendarFormat.week: "Week",
                  },
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF95989A),
                      fontWeight: FontWeight.bold,
                    ),
                    weekendStyle: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF95989A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onDaySelected: (DateTime selectDay, DateTime focusDay) {
                    setState(() {
                      focusedDay = selectDay;
                    });
                  },
                  selectedDayPredicate: (DateTime date) {
                    return isSameDay(focusedDay, date);
                  },
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      color: Color(0xFF1C3857),
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Color(0xFFFEA700),
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    outsideTextStyle: TextStyle(
                      color: Color(0xFF1C3857).withOpacity(0.65),
                      fontWeight: FontWeight.w600,
                    ),
                    weekendTextStyle: TextStyle(
                      color: Color(0xFF1C3857),
                      fontWeight: FontWeight.w600,
                    ),
                    defaultTextStyle: TextStyle(
                      color: Color(0xFF1C3857),
                      fontWeight: FontWeight.w600,
                    ),
                    disabledTextStyle: TextStyle(
                      color: Color(0xFF1C3857).withOpacity(0.65),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF1C3857),
                      fontWeight: FontWeight.bold,
                    ),
                    leftChevronIcon: Container(
                      padding: EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Color(0xFF95989A).withOpacity(0.3),
                        ),
                      ),
                      child: Icon(
                        Icons.chevron_left_rounded,
                        size: 35.0,
                        color: Color(0xFF1C3857),
                      ),
                    ),
                    rightChevronIcon: Container(
                      padding: EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Color(0xFF95989A).withOpacity(0.3),
                        ),
                      ),
                      child: Icon(
                        Icons.chevron_right_rounded,
                        size: 35.0,
                        color: Color(0xFF1C3857),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 30.0,
                  bottom: 10.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: Text(
                  "Pick Time",
                  style: TextStyle(
                    fontSize: 23.0,
                    color: Color(0xFF1C3857),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TimePicker(
                onTimeChange: (DateTime timeSpinnerVal) {
                  setState(() {
                    time = timeSpinnerVal;
                  });
                },
              ),
            ],
          ),
          TimingsFooter(
            time: time,
            focusedDay: focusedDay,
            widget: widget,
          ),
        ],
      ),
    );
  }
}
