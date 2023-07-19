// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
// File Imports
import 'package:help4you/constants/search_bar.dart';
import 'package:help4you/models/service_category_model.dart';
import 'package:help4you/screens/categories_screen/components/occupation_banner.dart';

class CategoryBannerStream extends StatefulWidget {
  const CategoryBannerStream({Key? key}) : super(key: key);

  @override
  State<CategoryBannerStream> createState() => _CategoryBannerStreamState();
}

class _CategoryBannerStreamState extends State<CategoryBannerStream> {
  // Search Controller
  TextEditingController searchController = TextEditingController();

  Future? resultsLoaded;
  List allResults = [];
  List resultsList = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getServiceCategoryList();
  }

  onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];
    if (searchController.text != "") {
      for (var categorySnapshot in allResults) {
        var category = ServiceCategoryBanner.fromSnapshot(categorySnapshot)
            .occupation
            ?.toLowerCase();
        if (category!.contains(searchController.text.toLowerCase())) {
          showResults.add(categorySnapshot);
        }
      }
    } else {
      showResults = List.from(allResults);
    }
    setState(() {
      resultsList = showResults;
    });
  }

  getServiceCategoryList() async {
    var data = await FirebaseFirestore.instance
        .collection("H4Y Occupation Database")
        .orderBy("Occupation")
        .get();

    setState(() {
      allResults = data.docs;
    });
    searchResultsList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15.0),
        CustomSearchBar(
          width: MediaQuery.of(context).size.width,
          hintText: "Search categories...",
          controller: searchController,
        ),
        const SizedBox(height: 15.0),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: resultsList.length,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot = resultsList[index];
              return OccupationBanner(
                buttonBanner: documentSnapshot["Button Banner"],
                occupation: documentSnapshot["Occupation"],
              );
            },
          ),
        )
      ],
    );
  }
}
