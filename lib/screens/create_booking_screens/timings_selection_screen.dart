// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/screens/create_booking_screens/components/time_picker.dart';
import 'package:help4you/screens/create_booking_screens/components/timings_footer.dart';

class TimingsSelectionScreen extends StatefulWidget {
  final String professionalUID;
  final String completeAddress;
  final GeoPoint geoPointLocation;

  const TimingsSelectionScreen({
    Key key,
    @required this.professionalUID,
    this.completeAddress,
    this.geoPointLocation,
  }) : super(key: key);

  @override
  TimingsSelectionScreenState createState() => TimingsSelectionScreenState();
}

class TimingsSelectionScreenState extends State<TimingsSelectionScreen> {
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
        leading: const SignatureButton(type: "Back Button"),
        title: const Text(
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
              const Padding(
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TableCalendar(
                  firstDay: firstDay,
                  lastDay: lastDay,
                  focusedDay: focusedDay,
                  calendarFormat: CalendarFormat.week,
                  availableCalendarFormats: const {
                    CalendarFormat.week: "Week",
                  },
                  daysOfWeekStyle: const DaysOfWeekStyle(
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
                    selectedDecoration: const BoxDecoration(
                      color: Color(0xFF1C3857),
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    todayDecoration: const BoxDecoration(
                      color: Color(0xFFFEA700),
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    outsideTextStyle: TextStyle(
                      color: const Color(0xFF1C3857).withOpacity(0.65),
                      fontWeight: FontWeight.w600,
                    ),
                    weekendTextStyle: const TextStyle(
                      color: Color(0xFF1C3857),
                      fontWeight: FontWeight.w600,
                    ),
                    defaultTextStyle: const TextStyle(
                      color: Color(0xFF1C3857),
                      fontWeight: FontWeight.w600,
                    ),
                    disabledTextStyle: TextStyle(
                      color: const Color(0xFF1C3857).withOpacity(0.65),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    titleTextStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF1C3857),
                      fontWeight: FontWeight.bold,
                    ),
                    leftChevronIcon: Container(
                      padding: const EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: const Color(0xFF95989A).withOpacity(0.3),
                        ),
                      ),
                      child: const Icon(
                        Icons.chevron_left_rounded,
                        size: 35.0,
                        color: Color(0xFF1C3857),
                      ),
                    ),
                    rightChevronIcon: Container(
                      padding: const EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: const Color(0xFF95989A).withOpacity(0.3),
                        ),
                      ),
                      child: const Icon(
                        Icons.chevron_right_rounded,
                        size: 35.0,
                        color: Color(0xFF1C3857),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
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
