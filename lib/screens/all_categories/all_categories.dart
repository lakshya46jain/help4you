// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/screens/all_categories/body.dart';
import 'package:help4you/screens/all_categories/app_bar.dart';

class AllServicesScreen extends StatefulWidget {
  @override
  _AllServicesScreenState createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends State<AllServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height / (1792 / 100),
          ),
          child: AllCategoriesAppBar(),
        ),
        body: Body(),
      ),
    );
  }
}
