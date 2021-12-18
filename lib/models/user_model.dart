// Help4You Unique User ID
class Help4YouUser {
  final String uid;

  Help4YouUser({
    this.uid,
  });
}

// Help4You Customer Details
class UserDataCustomer {
  final String uid;
  final String fullName;
  final String profilePicture;
  final String countryCode;
  final String phoneIsoCode;
  final String nonInternationalNumber;
  final String phoneNumber;
  final String emailAddress;
  final int adminLevel;
  final String status;

  UserDataCustomer({
    this.uid,
    this.fullName,
    this.profilePicture,
    this.countryCode,
    this.phoneIsoCode,
    this.nonInternationalNumber,
    this.phoneNumber,
    this.emailAddress,
    this.adminLevel,
    this.status,
  });
}
