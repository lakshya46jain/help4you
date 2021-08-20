// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/constants/loading.dart';
import 'package:help4you/constants/back_button.dart';
import 'package:help4you/constants/search_bar.dart';
import 'package:help4you/models/service_category_model.dart';
import 'package:help4you/secondary_screens/categories_screen/occupation_banner.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // Search Controller
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: CustomBackButton(),
          title: Text(
            "Categories",
            style: TextStyle(
              fontSize: 25.0,
              color: Color(0xFF1C3857),
              fontFamily: "BalooPaaji",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 15.0,
            ),
            SearchBar(
              width: MediaQuery.of(context).size.width,
              hintText: "Search categories...",
              controller: searchController,
            ),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: StreamBuilder(
                stream: DatabaseService(uid: user.uid).serviceCategoryData,
                builder: (context, snapshot) {
                  List<ServiceCategory> servicesCategory = snapshot.data;
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: servicesCategory.length,
                      itemBuilder: (context, index) {
                        return OccupationBanner(
                          buttonBanner: servicesCategory[index].buttonBanner,
                          occupation: servicesCategory[index].occupation,
                        );
                      },
                    );
                  } else {
                    return DoubleBounceLoading();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
