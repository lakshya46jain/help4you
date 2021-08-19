// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/primary_screens/bottom_nav_bar.dart';
import 'package:help4you/primary_screens/onboarding_screen/onboarding_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser>(context);

    // Firebase Crashlytics User Identifier
    if (user != null) {
      FirebaseCrashlytics.instance.setUserIdentifier(user.uid);
    } else {
      FirebaseCrashlytics.instance.setUserIdentifier("Anonyomous User");
    }

    return PageTransitionSwitcher(
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      child: user != null ? BottomNavBar() : OnboardingScreen(),
    );
  }
}
