// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:intl/intl.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/screens/create_booking_screens/components/booking_service_tile.dart';

class SummaryBody extends StatelessWidget {
  final String professionalUID;
  final Help4YouUser user;
  final String completeAddress;
  final DateTime bookingTimings;

  const SummaryBody({
    Key key,
    @required this.professionalUID,
    @required this.user,
    @required this.completeAddress,
    @required this.bookingTimings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService(uid: user.uid, professionalUID: professionalUID)
          .filteredCartServiceListData,
      builder: (context, snapshot) {
        List<CartServices> cartServices = snapshot.data;
        if (snapshot.hasData) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 20.0,
                  ),
                  child: Text.rich(
                    TextSpan(
                      text: "Selected Address:",
                      style: const TextStyle(
                        color: Color(0xFF1C3857),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      children: [
                        TextSpan(
                          text: " $completeAddress",
                          style: const TextStyle(
                            color: Color(0xFF95989A),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Text.rich(
                    TextSpan(
                      text: "Preferred Timing:",
                      style: const TextStyle(
                        color: Color(0xFF1C3857),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      children: [
                        TextSpan(
                          text:
                              " ${DateFormat.jm().format(bookingTimings.toLocal())} on ${DateFormat("d MMMM yyyy").format(bookingTimings.toLocal())}",
                          style: const TextStyle(
                            color: Color(0xFF95989A),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(
                    thickness: 3.0,
                    color: const Color(0xFF95989A).withOpacity(0.2),
                  ),
                ),
                const SizedBox(height: 25.0),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Ordered Services",
                    style: TextStyle(
                      height: 1.0,
                      color: Color(0xFF1C3857),
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartServices.length,
                  padding: const EdgeInsets.all(0.0),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return BookingServiceTile(
                      serviceId: cartServices[index].serviceId,
                      professionalId: cartServices[index].professionalId,
                      serviceTitle: cartServices[index].serviceTitle,
                      serviceDescription:
                          cartServices[index].serviceDescription,
                      servicePrice: cartServices[index].servicePrice,
                      quantity: cartServices[index].quantity,
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
