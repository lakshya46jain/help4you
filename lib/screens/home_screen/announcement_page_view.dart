// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
// File Imports
import 'package:help4you/services/database.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/models/announcement_model.dart';

class AnnouncementPageView extends StatelessWidget {
  // URL Launcher
  Future _launchInApp(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: StreamBuilder(
        stream: DatabaseService(uid: user.uid).announcements,
        builder: (context, snapshot) {
          List<Announcements> announcements = snapshot.data;
          return Swiper(
            scale: 0.9,
            autoplay: true,
            viewportFraction: 0.8,
            scrollDirection: Axis.horizontal,
            itemCount: announcements.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (announcements[index].websiteUrl != "") {
                    _launchInApp(
                      announcements[index].websiteUrl,
                    );
                  }
                },
                child: Container(
                  height: 200.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: announcements[index].imageUrl,
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
