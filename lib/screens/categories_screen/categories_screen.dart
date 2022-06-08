// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
// File Imports
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/screens/categories_screen/components/category_banner_stream.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: const SignatureButton(type: "Back Button"),
          title: const Text(
            "Categories",
            style: TextStyle(
              fontSize: 25.0,
              color: Color(0xFF1C3857),
              fontFamily: "BalooPaaji",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: const CategoryBannerStream(),
      ),
    );
  }
}
