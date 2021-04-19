// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cached_network_image/cached_network_image.dart';
// File Imports

class ProfessionalCategory extends StatelessWidget {
  final String imageUrl;
  final String occupation;

  ProfessionalCategory({
    this.imageUrl,
    this.occupation,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate To Service
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 0.0,
          top: 20.0,
          bottom: 20.0,
        ),
        child: Container(
          height: 60.0,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFECDF),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                occupation,
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
