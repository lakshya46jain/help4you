import 'package:cloud_firestore/cloud_firestore.dart';

// Address Model
class Address {
  final String addressId;
  final GeoPoint geoPoint;
  final String addressName;
  final String completeAddress;
  final String addressType;

  Address({
    this.addressId,
    this.geoPoint,
    this.addressName,
    this.completeAddress,
    this.addressType,
  });
}
