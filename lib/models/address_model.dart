import 'package:cloud_firestore/cloud_firestore.dart';

// Address Model
class Address {
  final String addressId;
  final String customerUID;
  final GeoPoint geoPoint;
  final String addressName;
  final String completeAddress;
  final int addressType;

  Address({
    this.addressId,
    this.customerUID,
    this.geoPoint,
    this.addressName,
    this.completeAddress,
    this.addressType,
  });
}
