import 'package:cloud_firestore/cloud_firestore.dart';

// Address Model
class Address {
  final String customerUID;
  final String addressId;
  final String addressName;
  final String completeAddress;
  final int addressType;
  final GeoPoint geoPoint;

  Address({
    this.customerUID,
    this.addressId,
    this.addressName,
    this.completeAddress,
    this.addressType,
    this.geoPoint,
  });
}
