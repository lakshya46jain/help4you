// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/screens/categories_screen/categories_screen.dart';
import 'package:help4you/screens/home_screen/components/category_horizontal_list.dart';

class OccupationListBuilder extends StatelessWidget {
  const OccupationListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser?>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: GoogleFonts.balooPaaji2(
                  fontSize: 25.0,
                  color: const Color(0xFF1C3857),
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoriesScreen(),
                    ),
                  );
                },
                child: Text(
                  "See All",
                  style: GoogleFonts.balooPaaji2(
                    fontSize: 19.0,
                    color: const Color(0xFFFEA700),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5.0),
        CategoryHorizontalList(
          user: user,
        ),
      ],
    );
  }
}
