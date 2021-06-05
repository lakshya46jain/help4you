// Flutter Imports
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/models/cart_service_model.dart';

class DatabaseService {
  final String uid;

  DatabaseService({
    this.uid,
  });

  // Collection Reference (User Database)
  final CollectionReference customerCollection =
      FirebaseFirestore.instance.collection('H4Y Users Database');

  // Update User Data
  Future updateUserData(
    String fullName,
    String phoneNumber,
    String phoneIsoCode,
    String nonInternationalNumber,
  ) async {
    return await customerCollection.doc(uid).set(
      {
        'Account Type': "Customer",
        'User UID': uid,
        'Full Name': fullName,
        'Phone Number': phoneNumber,
        'Phone ISO Code': phoneIsoCode,
        'Non International Number': nonInternationalNumber,
      },
    );
  }

  // Update User Profile Picture
  Future updateProfilePicture(
    String profilePicture,
  ) async {
    return await customerCollection.doc(uid).update(
      {
        'Profile Picture': profilePicture,
      },
    );
  }

  // Add To Cart
  Future addToCart(
    String serviceId,
    String professionalId,
    String serviceTitle,
    String serviceDescription,
    int servicePrice,
    int quantity,
  ) async {
    return await customerCollection
        .doc(uid)
        .collection("Cart")
        .doc(serviceId)
        .set(
      {
        'Service ID': serviceId,
        'Professional UID': professionalId,
        'Service Title': serviceTitle,
        'Service Description': serviceDescription,
        'Service Price': servicePrice,
        'Quantity': quantity,
      },
    );
  }

  // User Data from Snapshot
  UserDataCustomer _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserDataCustomer(
      uid: uid,
      fullName: snapshot.data()['Full Name'],
      phoneNumber: snapshot.data()['Phone Number'],
      phoneIsoCode: snapshot.data()['Phone ISO Code'],
      nonInternationalNumber: snapshot.data()['Non International Number'],
      profilePicture: snapshot.data()['Profile Picture'],
    );
  }

  // Get User Document
  Stream<UserDataCustomer> get userData {
    return customerCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
