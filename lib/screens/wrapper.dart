// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
// File Imports
import 'package:help4you/models/user_model.dart';
import 'package:help4you/screens/bottom_nav_bar.dart';
import 'package:help4you/screens/server_error_screen.dart';
import 'package:help4you/screens/onboarding_screen/onboarding_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  // Check Internet Connectivity
  bool? hasConnection;
  checkInternetConnectivity() async {
    hasConnection = await InternetConnectionChecker().hasConnection;
    setState(() {});
  }

  @override
  void initState() {
    checkInternetConnectivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get User
    final user = Provider.of<Help4YouUser?>(context);

    return PageTransitionSwitcher(
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      child: (hasConnection == false)
          ? ServerErrorScreen(
              onPressed: () => checkInternetConnectivity(),
            )
          // ignore: unnecessary_null_comparison
          : (user != null)
              ? const BottomNavBar()
              : const OnboardingScreen(),
    );
  }
}
