// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/secondary_screens/create_booking_screen/edit_address_screen.dart';

class SavedAddressTile extends StatelessWidget {
  final String uid;
  final String addressId;
  final String addressName;
  final String completeAddress;
  final int addressType;
  final GeoPoint geoPointLocation;

  SavedAddressTile({
    @required this.uid,
    @required this.addressId,
    @required this.addressName,
    @required this.completeAddress,
    @required this.addressType,
    @required this.geoPointLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 20.0,
        ),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                addressName,
                style: TextStyle(
                  fontSize: 21.0,
                  color: Color(0xFF1C3857),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                (addressType == 0)
                    ? "Home"
                    : (addressType == 1)
                        ? "Office"
                        : "Other",
                style: TextStyle(
                  color: Color(0xFF1C3857),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                completeAddress,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF95989A),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 3.0,
                color: Color(0xFF95989A).withOpacity(0.2),
              ),
            ],
          ),
        ),
      ),
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          color: Color(0xFF1C3857),
          iconWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FluentIcons.edit_24_regular,
                color: Colors.white,
                size: 30.0,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Update",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              )
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditAddressScreen(
                  addressId: addressId,
                ),
              ),
            );
          },
        ),
        IconSlideAction(
          color: Colors.red,
          iconWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FluentIcons.delete_24_regular,
                color: Colors.white,
                size: 30.0,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Delete",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              )
            ],
          ),
          onTap: () async {
            await FirebaseFirestore.instance
                .collection("H4Y Users Database")
                .doc(uid)
                .collection("Saved Address")
                .doc(addressId)
                .delete();
          },
        ),
      ],
    );
  }
}
