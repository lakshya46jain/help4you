// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports

class UniqueUsersTile extends StatelessWidget {
  final String uid;
  final VoidCallback onTap;
  final int index;
  final int selected;

  const UniqueUsersTile({
    Key? key,
    required this.uid,
    required this.onTap,
    required this.index,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("H4Y Users Database")
              .doc(uid)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              String profilePicture = snapshot.data["Profile Picture"];
              String fullName = snapshot.data["Full Name"];
              String occupation = snapshot.data["Occupation"];
              return Row(
                children: [
                  Container(
                    height: 25.0,
                    width: 25.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFF95989A).withOpacity(0.6),
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        height: 15.0,
                        width: 15.0,
                        decoration: BoxDecoration(
                          color: (selected == index)
                              ? const Color(0xFF1C3857)
                              : Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 55.0,
                              height: 55.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.black,
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      profilePicture),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fullName,
                                  style: const TextStyle(
                                    fontSize: 21.0,
                                    color: Color(0xFF1C3857),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  occupation,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF95989A),
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 3.0,
                          color: const Color(0xFF95989A).withOpacity(0.2),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
