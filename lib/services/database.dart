// Flutter Imports
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/models/service_category_model.dart';

class DatabaseService {
  final String uid;

  DatabaseService({
    this.uid,
  });

  // Collection Reference (User Database)
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('H4Y Users Database');

  // Collection Reference (Occupation Database)
  final CollectionReference occupationCollection =
      FirebaseFirestore.instance.collection('H4Y Occupation Database');

  // Update User Data
  Future updateUserData(
    String fullName,
    String phoneNumber,
    String phoneIsoCode,
    String nonInternationalNumber,
  ) async {
    return await userCollection.doc(uid).set(
      {
        'Account Type': "Customer",
        'User UID': uid,
        'Full Name': fullName,
        'Administrative Level': 0,
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
    return await userCollection.doc(uid).update(
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
    double servicePrice,
    int quantity,
  ) async {
    return await userCollection.doc(uid).collection("Cart").doc(serviceId).set(
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

  // Update Cart Quantity
  Future updateQuantity(
    String serviceId,
    int quantity,
  ) async {
    return await userCollection
        .doc(uid)
        .collection("Cart")
        .doc(serviceId)
        .update(
      {
        'Quantity': quantity,
      },
    );
  }

  // User Data from Snapshot
  UserDataCustomer _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserDataCustomer(
      uid: uid,
      fullName: snapshot['Full Name'],
      phoneNumber: snapshot['Phone Number'],
      phoneIsoCode: snapshot['Phone ISO Code'],
      nonInternationalNumber: snapshot['Non International Number'],
      profilePicture: snapshot['Profile Picture'],
      adminLevel: snapshot['Administrative Level'],
    );
  }

  // Service Data from Snapshot
  List<Help4YouCartServices> _help4youCartServicesFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.toList().map(
      (document) {
        Help4YouCartServices help4youCartServices = Help4YouCartServices(
          professionalId: document["Professional UID"],
          serviceId: document["Service ID"],
          serviceTitle: document["Service Title"],
          serviceDescription: document["Service Description"],
          servicePrice: document["Service Price"],
          quantity: document["Quantity"],
        );
        return help4youCartServices;
      },
    ).toList();
  }

  // Service Category Data from Snapshot
  List<ServiceCategory> _help4YouServiceCategoryFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.toList().map(
      (document) {
        ServiceCategory help4youServiceCategory = ServiceCategory(
          buttonLogo: document["Button Logo"],
          buttonBanner: document["Button Banner"],
          occupation: document["Occupation"],
        );
        return help4youServiceCategory;
      },
    ).toList();
  }

  // Get User Document
  Stream<UserDataCustomer> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // Get Service Document
  Stream<List<Help4YouCartServices>> get cartServiceData {
    return userCollection
        .doc(uid)
        .collection("Cart")
        .snapshots()
        .map(_help4youCartServicesFromSnapshot);
  }

  // Get Service Category Document
  Stream<List<ServiceCategory>> get serviceCategoryData {
    return occupationCollection
        .orderBy("Occupation")
        .snapshots()
        .map(_help4YouServiceCategoryFromSnapshot);
  }
}
