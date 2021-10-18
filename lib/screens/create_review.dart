// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:simple_star_rating/simple_star_rating.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/database.dart';
import 'package:help4you/constants/back_button.dart';
import 'package:help4you/constants/signature_button.dart';
import 'package:help4you/constants/custom_text_field.dart';

class CreateReviewScreen extends StatefulWidget {
  final String uid;

  CreateReviewScreen({
    @required this.uid,
  });

  @override
  _CreateReviewScreenState createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  // Variables
  double rating;
  String review;
  int selected = 0;
  bool isRecommended;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Custom Radio Button
  Widget customRadioButton(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(8.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(
            width: 3,
            color: (index == selected)
                ? Color(0xFF1C3857).withOpacity(0.4)
                : Color(0xFF95989A).withOpacity(0.2),
          ),
        ),
        width: (index == 0) ? 177.5 : 218.5,
        child: Center(
          child: Row(
            children: [
              Icon(
                (index == 0)
                    ? Icons.thumb_up_rounded
                    : Icons.thumb_down_rounded,
                color: (index == 0) ? Colors.lightGreen : Colors.red,
              ),
              SizedBox(
                width: 7.5,
              ),
              Text(
                (index == 0) ? "Recommended" : "Do Not Recommend",
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
            "Create Review",
            style: TextStyle(
              fontSize: 25.0,
              color: Color(0xFF1C3857),
              fontFamily: "BalooPaaji",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Give Your Rating",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SimpleStarRating(
                    isReadOnly: false,
                    filledIcon: Icon(
                      FluentIcons.star_24_filled,
                      size: 35.0,
                      color: Color(0xFFFEA700),
                    ),
                    nonFilledIcon: Icon(
                      FluentIcons.star_24_filled,
                      size: 35.0,
                      color: Color(0xFF95989A).withOpacity(0.3),
                    ),
                    onRated: (value) {
                      setState(() {
                        rating = value;
                      });
                      if (rating > 3.5) {
                        setState(() {
                          selected = 0;
                        });
                      } else {
                        selected = 1;
                      }
                    },
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  CustomTextField(
                    maxLines: 10,
                    hintText: "Please write a review...",
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) {
                      setState(() {
                        review = value;
                      });
                    },
                    validator: (value) {
                      if (review.isEmpty) {
                        return "Please provide a review to the professional";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    "Do you recommend the professional to others?",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customRadioButton(0),
                      SizedBox(
                        height: 10.0,
                      ),
                      customRadioButton(1),
                    ],
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  SignatureButton(
                    onTap: () async {
                      if (selected == 0) {
                        setState(() {
                          isRecommended = true;
                        });
                      } else {
                        setState(() {
                          isRecommended = false;
                        });
                      }
                      if (formKey.currentState.validate() && rating != 0.0)
                        await DatabaseService(
                          uid: user.uid,
                          professionalUID: widget.uid,
                        ).createReview(
                          rating,
                          review,
                          isRecommended,
                        );
                      Navigator.pop(context);
                    },
                    text: "Add Review",
                    withIcon: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}