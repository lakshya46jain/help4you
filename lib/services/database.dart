// Flutter Imports
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/models/booking_model.dart';
import 'package:help4you/models/address_model.dart';
import 'package:help4you/models/reviews_model.dart';
import 'package:help4you/models/messages_model.dart';
import 'package:help4you/models/chat_room_model.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/models/service_category_model.dart';

class DatabaseService {
  final String uid;
  final String professionalUID;
  final String serviceId;
  final String addressId;
  final String bookingId;
  final String bookingStatus;

  DatabaseService({
    this.uid,
    this.professionalUID,
    this.serviceId,
    this.addressId,
    this.bookingId,
    this.bookingStatus,
  });

  // Collection Reference (User Database)
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('H4Y Users Database');

  // Collection Reference (Saved Address Database)
  final CollectionReference savedAddressCollection =
      FirebaseFirestore.instance.collection("H4Y Saved Address Database");

  // Collection Reference (Occupation Database)
  final CollectionReference occupationCollection =
      FirebaseFirestore.instance.collection('H4Y Occupation Database');

  // Collection Reference (Chat Room Database)
  final CollectionReference chatRoomCollection =
      FirebaseFirestore.instance.collection("H4Y Chat Rooms Database");

  // Collection Reference (Reviews Database)
  final CollectionReference reviewsCollection =
      FirebaseFirestore.instance.collection("H4Y Reviews Database");

  // Collection Reference (Bookings Database)
  final CollectionReference bookingsCollection =
      FirebaseFirestore.instance.collection("H4Y Bookings Database");

  // Update User Data
  Future updateUserData(
    String fullName,
    String countryCode,
    String phoneIsoCode,
    String nonInternationalNumber,
    String phoneNumber,
    String emailAddress,
  ) async {
    await userCollection.doc(uid).set({
      'Full Name': fullName,
      'Administrative Level': 0,
      'Account Type': "Customer",
      'Country Code': countryCode,
      'Phone ISO Code': phoneIsoCode,
      'Non International Number': nonInternationalNumber,
      'Phone Number': phoneNumber,
      'Email Address': emailAddress,
      'Status': 'Offline',
    });
  }

  // Update User Profile Picture
  Future updateProfilePicture(
    String profilePicture,
  ) async {
    await userCollection.doc(uid).update({
      'Profile Picture': profilePicture,
    });
  }

  // Update User Email Address
  Future updateEmailAddress(
    String emailAddress,
  ) async {
    await userCollection.doc(uid).update({
      'Email Address': emailAddress,
    });
  }

  // Update User Online Status
  Future updateUserStatus(
    String status,
  ) async {
    await userCollection.doc(uid).update({
      'Status': status,
    });
  }

  // Add To Cart
  Future addToCart(
    String serviceId,
    String serviceTitle,
    String serviceDescription,
    double servicePrice,
    int quantity,
  ) async {
    await userCollection.doc(uid).collection("Cart").doc(serviceId).set({
      'Service Title': serviceTitle,
      'Service Description': serviceDescription,
      'Service Price': servicePrice,
      'Quantity': quantity,
      'Professional UID': professionalUID,
    });
  }

  // Update Cart Quantity
  Future updateQuantity(
    String serviceId,
    int quantity,
  ) async {
    await userCollection.doc(uid).collection("Cart").doc(serviceId).update({
      'Quantity': quantity,
    });
  }

  // Create Chat Room
  Future createChatRoom() async {
    DocumentSnapshot ds =
        await chatRoomCollection.doc("$uid\_$professionalUID").get();
    if (!ds.exists) {
      await chatRoomCollection.doc("$uid\_$professionalUID").set({
        "Chat Room ID": "$uid\_$professionalUID",
        "Connection Date": DateTime.now().toUtc(),
        "Customer UID": uid,
        "Professional UID": professionalUID,
      });
    }
  }

  // Add Chat Room Messages
  Future addMessageToChatRoom(
    String type,
    String message,
  ) async {
    await chatRoomCollection
        .doc("$uid\_$professionalUID")
        .collection("Messages")
        .doc()
        .set({
      "Sender": uid,
      "Type": type,
      "Message": message,
      "Time Stamp": DateTime.now().toUtc(),
    });
  }

  // Create Reviews
  Future createReview(
    double rating,
    String review,
    bool isRecommended,
  ) async {
    await reviewsCollection.doc().set({
      "Rating": rating,
      "Review": review,
      "Recommended": isRecommended,
      "Time Stamp": DateTime.now().toUtc(),
      "Customer UID": uid,
      "Professional UID": professionalUID,
    });
  }

  // Add Address
  Future addAdress(
    GeoPoint geoPoint,
    String addressName,
    String completeAddress,
    int addressType,
  ) async {
    await savedAddressCollection.doc().set({
      "Customer UID": uid,
      "Address Name": addressName,
      "Complete Address": completeAddress,
      "Address Type": addressType,
      "Geo Point Location": geoPoint,
    });
  }

  // Update Address
  Future updateAdress(
    GeoPoint geoPoint,
    String addressName,
    String completeAddress,
    int addressType,
  ) async {
    await savedAddressCollection.doc(addressId).update({
      "Address Name": addressName,
      "Complete Address": completeAddress,
      "Address Type": addressType,
      "Geo Point Location": geoPoint,
    });
  }

  // Create Booking
  Future createBooking(
    String bookingId,
    String address,
    GeoPoint addressGeoPoint,
    DateTime preferredTimings,
    String bookingStatus,
    List<Map> bookedItems,
    double totalPrice,
  ) async {
    await bookingsCollection.doc(bookingId).set({
      "Customer UID": uid,
      "Professional UID": professionalUID,
      "Booking Time": DateTime.now().toUtc(),
      "Address": address,
      "Address GeoPoint": addressGeoPoint,
      "Preferred Timings": preferredTimings,
      "Booking Status": bookingStatus,
      "Booked Items": bookedItems,
      "Total Price": totalPrice,
    });
  }

  // User Data from Snapshot
  UserDataCustomer _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserDataCustomer(
      uid: snapshot.id,
      fullName: snapshot['Full Name'],
      phoneNumber: snapshot['Phone Number'],
      countryCode: snapshot['Country Code'],
      phoneIsoCode: snapshot['Phone ISO Code'],
      nonInternationalNumber: snapshot['Non International Number'],
      emailAddress: snapshot["Email Address"],
      profilePicture: snapshot['Profile Picture'],
      adminLevel: snapshot['Administrative Level'],
      status: snapshot["Status"],
    );
  }

  // Service Data List from Snapshot
  List<CartServices> _help4youCartServicesListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.toList().map(
      (document) {
        CartServices help4youCartServices = CartServices(
          professionalId: document["Professional UID"],
          serviceId: document.id,
          serviceTitle: document["Service Title"],
          serviceDescription: document["Service Description"],
          servicePrice: document["Service Price"],
          quantity: document["Quantity"],
        );
        return help4youCartServices;
      },
    ).toList();
  }

  // Service Data from Snapshot
  CartServices _help4youCartServicesFromSnapshot(DocumentSnapshot snapshot) {
    return CartServices(
      professionalId: snapshot["Professional UID"],
      serviceId: snapshot.id,
      serviceTitle: snapshot["Service Title"],
      serviceDescription: snapshot["Service Description"],
      servicePrice: snapshot["Service Price"],
      quantity: snapshot["Quantity"],
    );
  }

  // Service Category Data from Snapshot
  List<ServiceCategoryLogo> _help4YouServiceCategoryFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.toList().map(
      (document) {
        ServiceCategoryLogo help4youServiceCategory = ServiceCategoryLogo(
          buttonLogo: document["Button Logo"],
          occupation: document["Occupation"],
        );
        return help4youServiceCategory;
      },
    ).toList();
  }

  // Chat Rooms from Snapshot
  List<ChatRoom> _help4YouChatRoomFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.toList().map((document) {
      ChatRoom help4YouChatRoom = ChatRoom(
          chatRoomId: document.id,
          connectionDate: document["Connection Date"],
          customerUID: document["Customer UID"],
          professionalUID: document["Professional UID"]);
      return help4YouChatRoom;
    }).toList();
  }

  // Messages Data from Snapshot
  List<Messages> _help4YouMessageFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.toList().map(
      (document) {
        Messages help4YouMessages = Messages(
          messageId: document.id,
          sender: document["Sender"],
          type: document["Type"],
          message: document["Message"],
          timeStamp: document["Time Stamp"],
        );
        return help4YouMessages;
      },
    ).toList();
  }

  // Reviews Data from Snapshot
  List<Reviews> _help4YouReviewsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.toList().map(
      (document) {
        Reviews help4YouReviews = Reviews(
          reviewId: document.id,
          professionalUID: document["Professional UID"],
          customerUID: document["Customer UID"],
          timestamp: document["Time Stamp"],
          rating: document["Rating"],
          review: document["Review"],
          isRecommended: document["Recommended"],
        );
        return help4YouReviews;
      },
    ).toList();
  }

  // Address Data List from Snapshot
  List<Address> _help4YouAddressListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.toList().map(
      (document) {
        Address help4YouAddress = Address(
          addressId: document.id,
          geoPoint: document["Geo Point Location"],
          addressName: document["Address Name"],
          completeAddress: document["Complete Address"],
          addressType: document["Address Type"],
        );
        return help4YouAddress;
      },
    ).toList();
  }

  // Address Data from Snapshot
  Address _help4YouAddressFromSnapshot(DocumentSnapshot snapshot) {
    return Address(
      addressId: snapshot.id,
      customerUID: snapshot["Customer UID"],
      geoPoint: snapshot["Geo Point Location"],
      addressName: snapshot["Address Name"],
      completeAddress: snapshot["Complete Address"],
      addressType: snapshot["Address Type"],
    );
  }

  // Bookings List from Snapshot
  List<Booking> _help4YouBookingsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.toList().map(
      (document) {
        Booking help4YouBookings = Booking(
          bookingId: document.id,
          customerUID: document["Customer UID"],
          professionalUID: document["Professional UID"],
          bookingTime: document["Booking Time"],
          address: document["Address"],
          addressGeoPoint: document["Address GeoPoint"],
          preferredTimings: document["Preferred Timings"],
          bookingStatus: document["Booking Status"],
          totalPrice: document["Total Price"],
        );
        return help4YouBookings;
      },
    ).toList();
  }

  // Bookings Data from Snapshot
  Booking _help4YouBookingDataFromSnapshot(DocumentSnapshot snapshot) {
    return Booking(
      bookingId: snapshot.id,
      customerUID: snapshot["Customer UID"],
      professionalUID: snapshot["Professional UID"],
      bookingTime: snapshot["Booking Time"],
      address: snapshot["Address"],
      addressGeoPoint: snapshot["Address GeoPoint"],
      preferredTimings: snapshot["Preferred Timings"],
      bookingStatus: snapshot["Booking Status"],
      totalPrice: snapshot["Total Price"],
    );
  }

  // Get User Document
  Stream<UserDataCustomer> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // Get Cart Service List Document
  Stream<List<CartServices>> get cartServiceListData {
    return userCollection
        .doc(uid)
        .collection("Cart")
        .snapshots()
        .map(_help4youCartServicesListFromSnapshot);
  }

  // Get Filtered Cart Service List Document
  Stream<List<CartServices>> get filteredCartServiceListData {
    return userCollection
        .doc(uid)
        .collection("Cart")
        .where("Professional UID", isEqualTo: professionalUID)
        .snapshots()
        .map(_help4youCartServicesListFromSnapshot);
  }

  // Get Service Document
  Stream<CartServices> get cartServiceData {
    return userCollection
        .doc(uid)
        .collection("Cart")
        .doc(serviceId)
        .snapshots()
        .map(_help4youCartServicesFromSnapshot);
  }

  // Get Service Category Document
  Stream<List<ServiceCategoryLogo>> get serviceCategoryData {
    return occupationCollection
        .orderBy("Occupation")
        .snapshots()
        .map(_help4YouServiceCategoryFromSnapshot);
  }

  // Get Chat Rooms Documents
  Stream<List<ChatRoom>> get chatRoomsData {
    return chatRoomCollection
        .where("Customer UID", isEqualTo: uid)
        .snapshots()
        .map(_help4YouChatRoomFromSnapshot);
  }

  // Get Messages Documents
  Stream<List<Messages>> get messagesData {
    return chatRoomCollection
        .doc("$uid\_$professionalUID")
        .collection("Messages")
        .orderBy("Time Stamp", descending: true)
        .snapshots()
        .map(_help4YouMessageFromSnapshot);
  }

  // Get Reviews Documents
  Stream<List<Reviews>> get reviewsData {
    return reviewsCollection
        .where("Professional UID", isEqualTo: professionalUID)
        .snapshots()
        .map(_help4YouReviewsFromSnapshot);
  }

  // Get Address List Documents
  Stream<List<Address>> get addressListData {
    return savedAddressCollection
        .where("Customer UID", isEqualTo: uid)
        .snapshots()
        .map(_help4YouAddressListFromSnapshot);
  }

  // Get Address Documents
  Stream<Address> get addressData {
    return savedAddressCollection
        .doc(addressId)
        .snapshots()
        .map(_help4YouAddressFromSnapshot);
  }

  // Get Bookings List
  Stream<List<Booking>> get bookingsListData {
    return bookingsCollection
        .where("Customer UID", isEqualTo: uid)
        .where("Booking Status", isEqualTo: bookingStatus)
        .snapshots()
        .map(_help4YouBookingsListFromSnapshot);
  }

  // Get Booking Documents
  Stream<Booking> get bookingsData {
    return bookingsCollection
        .doc(bookingId)
        .snapshots()
        .map(_help4YouBookingDataFromSnapshot);
  }
}
