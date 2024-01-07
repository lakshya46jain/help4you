// Flutter Imports
import 'package:flutter/material.dart';
import 'package:help4you/constants/signature_button.dart';
// Dependency Imports
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports

class TimeSlotsScreen extends StatefulWidget {
  final String? professionalUID;

  const TimeSlotsScreen({
    Key? key,
    this.professionalUID,
  }) : super(key: key);

  @override
  State<TimeSlotsScreen> createState() => TimeSlotsScreenState();
}

class TimeSlotsScreenState extends State<TimeSlotsScreen> {
  // Calendar Variables
  DateTime focusedDay = DateTime.now().toLocal();

  DateTime firstDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ).toLocal();

  DateTime lastDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day + 7,
  ).toLocal();

  static const timeSlot = {
    '08:00 AM',
    '08:30 AM',
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '12:00 PM',
    '12:30 PM',
    '01:00 PM',
    '01:30 PM',
    '02:00 PM',
    '02:30 PM',
    '03:00 PM',
    '03:30 PM',
    '04:00 PM',
    '04:30 PM',
    '05:00 PM',
    '05:30 PM',
    '06:00 PM',
    '06:30 PM',
    '07:00 PM',
  };

  int? selected;
  var preferredTimings = [];
  var unavailableIndex = [];

  Future checkTimeSlotAvailability(int index) async {
    final bookingsDataAccepted = await FirebaseFirestore.instance
        .collection("H4Y Bookings Database")
        .where("Professional UID", isEqualTo: widget.professionalUID)
        .where("Booking Status", isEqualTo: "Accepted")
        .get();

    for (var element in bookingsDataAccepted.docs) {
      if (element.exists) {
        preferredTimings
            .add(element.data()["Preferred Timings"].toDate().toLocal());
      }
    }

    final bookingsDataPending = await FirebaseFirestore.instance
        .collection("H4Y Bookings Database")
        .where("Professional UID", isEqualTo: widget.professionalUID)
        .where("Booking Status", isEqualTo: "Booking Pending")
        .get();

    for (var element in bookingsDataPending.docs) {
      if (element.exists) {
        preferredTimings
            .add(element.data()["Preferred Timings"].toDate().toLocal());
      }
    }

    if (preferredTimings.contains(
      DateTime(
        focusedDay.year,
        focusedDay.month,
        focusedDay.day,
        (timeSlot.elementAt(index).contains("PM") &&
                !timeSlot.elementAt(index).contains("12"))
            ? int.parse(
                    timeSlot.elementAt(index).split(':')[0].substring(0, 2)) +
                12
            : int.parse(
                timeSlot.elementAt(index).split(':')[0].substring(0, 2)),
        int.parse(timeSlot.elementAt(index).split(':')[1].substring(0, 2)),
      ),
    )) {
      unavailableIndex.add(index);
    } else if (DateTime.now().isAfter(
          DateTime(
            focusedDay.year,
            focusedDay.month,
            focusedDay.day,
            (timeSlot.elementAt(index).contains("PM") &&
                    !timeSlot.elementAt(index).contains("12"))
                ? int.parse(timeSlot
                        .elementAt(index)
                        .split(':')[0]
                        .substring(0, 2)) +
                    12
                : int.parse(
                    timeSlot.elementAt(index).split(':')[0].substring(0, 2)),
            int.parse(timeSlot.elementAt(index).split(':')[1].substring(0, 2)),
          ),
        ) ==
        true) {
      unavailableIndex.add(index);
    }
    // TODO: Fix the timings availability not updating.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Availability",
          style: GoogleFonts.balooPaaji2(
            fontSize: 25.0,
            color: const Color(0xFF1C3857),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: const SignatureButton(type: "Back Button"),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                "Service Dates",
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
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarFormat: CalendarFormat.week,
                availableCalendarFormats: const {CalendarFormat.week: "Week"},
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
                  unavailableIndex = [];
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
                    color: const Color(0xFF1C3857).withOpacity(0.5),
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
                    color: const Color(0xFF1C3857).withOpacity(0.5),
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
                "Service Timings",
                style: TextStyle(
                  fontSize: 23.0,
                  color: Color(0xFF1C3857),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: timeSlot.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.7,
                  ),
                  itemBuilder: (context, index) {
                    checkTimeSlotAvailability(index);
                    return Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 10,
                      ),
                      decoration: BoxDecoration(
                        color: (unavailableIndex.contains(index))
                            ? const Color(0xFFDB583F)
                            : const Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.only(left: 2),
                          child: Text(
                            timeSlot.elementAt(index),
                            style: TextStyle(
                              color: (unavailableIndex.contains(index))
                                  ? Colors.white
                                  : const Color.fromARGB(255, 7, 4, 4),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
