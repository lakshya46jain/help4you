// Flutter Imports
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/models/address_model.dart';
import 'package:help4you/models/reviews_model.dart';
import 'package:help4you/models/messages_model.dart';
import 'package:help4you/models/chat_room_model.dart';
import 'package:help4you/models/cart_service_model.dart';
import 'package:help4you/models/service_category_model.dart';

class DatabaseService {
  final String uid;
  final String professionalUID;
  final String chatRoomId;
  final String serviceId;
  final String addressId;

  DatabaseService({
    this.uid,
    this.professionalUID,
    this.chatRoomId,
    this.serviceId,
    this.addressId,
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

  // Update User Data
  Future updateUserData(
    String fullName,
    String phoneNumber,
    String phoneIsoCode,
    String nonInternationalNumber,
  ) async {
    await userCollection.doc(uid).set(
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
    await userCollection.doc(uid).update(
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
    await userCollection.doc(uid).collection("Cart").doc(serviceId).set(
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
    await userCollection.doc(uid).collection("Cart").doc(serviceId).update(
      {
        'Quantity': quantity,
      },
    );
  }

  // Create Chat Room
  Future createChatRoom(
    String customerUID,
    String professionalUID,
  ) async {
    DocumentSnapshot ds = await chatRoomCollection.doc(chatRoomId).get();
    if (!ds.exists) {
      await chatRoomCollection.doc(chatRoomId).set(
        {
          "Connection Date": DateTime.now().toUtc(),
          "Chat Room ID": chatRoomId,
          "Customer UID": customerUID,
          "Professional UID": professionalUID,
        },
      );
    }
  }

  // Add Chat Room Messages
  Future addMessageToChatRoom(
    String chatRoomId,
    String message,
    String sender,
  ) async {
    await chatRoomCollection.doc(chatRoomId).collection("Messages").doc().set(
      {
        "Message": message,
        "Sender": sender,
        "Time Stamp": DateTime.now().toUtc(),
      },
    );
  }

  // Create Reviews
  Future createReview(
    double rating,
    String review,
    bool isRecommended,
  ) async {
    await reviewsCollection.doc().set(
      {
        "Professional UID": professionalUID,
        "Customer UID": uid,
        "Time Stamp": DateTime.now().toUtc(),
        "Rating": rating,
        "Review": review,
        "Recommended": isRecommended,
      },
    );
  }

  // Add Address
  Future addAdress(
    GeoPoint geoPoint,
    String addressName,
    String completeAddress,
    int addressType,
  ) async {
    await savedAddressCollection.doc().set(
      {
        "Customer UID": uid,
        "Geo Point Location": geoPoint,
        "Address Name": addressName,
        "Complete Address": completeAddress,
        "Address Type": addressType,
      },
    );
  }

  // Add Address
  Future updateAdress(
    GeoPoint geoPoint,
    String addressName,
    String completeAddress,
    int addressType,
  ) async {
    await savedAddressCollection.doc(addressId).update(
      {
        "Geo Point Location": geoPoint,
        "Address Name": addressName,
        "Complete Address": completeAddress,
        "Address Type": addressType,
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

  // Service Data List from Snapshot
  List<Help4YouCartServices> _help4youCartServicesListFromSnapshot(
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

  // Service Data from Snapshot
  Help4YouCartServices _help4youCartServicesFromSnapshot(
      DocumentSnapshot snapshot) {
    return Help4YouCartServices(
      professionalId: snapshot["Professional UID"],
      serviceId: snapshot["Service ID"],
      serviceTitle: snapshot["Service Title"],
      serviceDescription: snapshot["Service Description"],
      servicePrice: snapshot["Service Price"],
      quantity: snapshot["Quantity"],
    );
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

  // Chat Rooms from Snapshot
  List<ChatRoom> _help4YouChatRoomFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.toList().map((document) {
      ChatRoom help4YouChatRoom = ChatRoom(
          chatRoomId: document["Chat Room ID"],
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

  // Address Data from Snapshot
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

  // Get User Document
  Stream<UserDataCustomer> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // Get Service List Document
  Stream<List<Help4YouCartServices>> get cartServiceListData {
    return userCollection
        .doc(uid)
        .collection("Cart")
        .snapshots()
        .map(_help4youCartServicesListFromSnapshot);
  }

  // Get Service Document
  Stream<Help4YouCartServices> get cartServiceData {
    return userCollection
        .doc(uid)
        .collection("Cart")
        .doc(serviceId)
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
        .doc(chatRoomId)
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
}
