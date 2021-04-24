// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports

class AnnouncementPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("H4Y Announcements Database")
            .snapshots(),
        builder: (context, snapshot) {
          return Swiper(
            scale: 0.9,
            autoplay: true,
            viewportFraction: 0.8,
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
              return GestureDetector(
                onTap: () {
                  // TODO: Give Functionality To Carousel Gesture Detector
                },
                child: Container(
                  height: 200.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: documentSnapshot["Image URL"],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
