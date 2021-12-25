import 'package:cloud_firestore/cloud_firestore.dart';

// Services Category Model
class ServiceCategoryLogo {
  final String occupation;
  final String buttonLogo;

  ServiceCategoryLogo({
    this.occupation,
    this.buttonLogo,
  });
}

class ServiceCategoryBanner {
  final String occupation;
  final String buttonBanner;

  ServiceCategoryBanner(
    this.occupation,
    this.buttonBanner,
  );

  ServiceCategoryBanner.fromSnapshot(DocumentSnapshot snapshot)
      : occupation = snapshot["Occupation"],
        buttonBanner = snapshot["Button Banner"];
}
