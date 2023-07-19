// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
// File Imports
import 'package:help4you/screens/create_booking_screens/update_address_screen.dart';

class SavedAddressTile extends StatelessWidget {
  final String? uid;
  final String? addressId;
  final String? addressName;
  final String? completeAddress;
  final int? addressType;
  final GeoPoint? geoPointLocation;
  final int? index;
  final int? selected;
  final VoidCallback? onTap;

  const SavedAddressTile({
    Key? key,
    required this.uid,
    required this.addressId,
    required this.addressName,
    required this.completeAddress,
    required this.addressType,
    required this.geoPointLocation,
    required this.index,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              backgroundColor: const Color(0xFF1C3857),
              icon: CupertinoIcons.pencil,
              label: "Update",
              onPressed: (context) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateAddressScreen(
                      addressId: addressId,
                    ),
                  ),
                );
              },
            ),
            SlidableAction(
              backgroundColor: Colors.red,
              icon: CupertinoIcons.delete,
              label: "Delete",
              onPressed: (context) async {
                await FirebaseFirestore.instance
                    .collection("H4Y Saved Addresses Database")
                    .doc(addressId)
                    .delete();
              },
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 25.0,
                width: 25.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFF95989A).withOpacity(0.6),
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    height: 15.0,
                    width: 15.0,
                    decoration: BoxDecoration(
                      color: (selected == index)
                          ? const Color(0xFF1C3857)
                          : Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15.0),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        addressName!,
                        style: const TextStyle(
                          fontSize: 21.0,
                          color: Color(0xFF1C3857),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        (addressType == 0)
                            ? "Home"
                            : (addressType == 1)
                                ? "Office"
                                : "Other",
                        style: const TextStyle(
                          color: Color(0xFF1C3857),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        completeAddress!,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF95989A),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Divider(
                        thickness: 3.0,
                        color: const Color(0xFF95989A).withOpacity(0.2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
