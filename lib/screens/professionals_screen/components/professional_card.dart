// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Dependency Imports
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports

class ProfessionalCard extends StatelessWidget {
  final String uid;
  final String fullName;
  final String occupation;
  final double rating;
  final String profilePicture;

  const ProfessionalCard({
    Key? key,
    required this.uid,
    required this.fullName,
    required this.occupation,
    required this.rating,
    required this.profilePicture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 35.0),
            child: Container(
              height: 140.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 15),
                    blurRadius: 20.0,
                    color: Color(0xFFDADADA),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 95.0,
                  top: 15.0,
                  bottom: 15.0,
                  right: 10.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fullName,
                      style: GoogleFonts.balooPaaji2(
                        height: 1.0,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1C3857),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      occupation,
                      style: GoogleFonts.balooPaaji2(
                        height: 1.0,
                        fontSize: 17.0,
                        color: const Color(0xFF95989A),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rating",
                              style: GoogleFonts.balooPaaji2(
                                height: 1.0,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2.5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  CupertinoIcons.star_fill,
                                  color: Color(0xFFFEA700),
                                  size: 16.0,
                                ),
                                const SizedBox(width: 2.5),
                                Text(
                                  "$rating",
                                  style: GoogleFonts.balooPaaji2(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Services",
                              style: GoogleFonts.balooPaaji2(
                                height: 1.0,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2.5),
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("H4Y Services Database")
                                  .where("Professional UID", isEqualTo: uid)
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                int totalServices = 0;
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  List documents = snapshot.data.docs;
                                  totalServices = documents.length;
                                }
                                return Text(
                                  "$totalServices",
                                  style: GoogleFonts.balooPaaji2(
                                    fontSize: 16.0,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 15,
            child: SizedBox(
              height: 110,
              width: 110,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color(0xFFF5F6F9),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 15),
                      blurRadius: 20.0,
                      color: Color(0xFFDADADA),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CachedNetworkImage(
                    imageUrl: profilePicture,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
