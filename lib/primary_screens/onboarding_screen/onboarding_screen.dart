// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:page_transition/page_transition.dart';
// File Imports
import 'package:help4you/constants/phone_number_field.dart';
import 'package:help4you/primary_screens/onboarding_screen/page_view_container.dart';
import 'package:help4you/primary_screens/onboarding_screen/phone_authentication.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Initial Page Value
  int _currentPage = 0;

  // Phone Number Field Variables
  String countryCode;
  String phoneIsoCode;
  String nonInternationalNumber;
  FocusNode focusNode = FocusNode();

  // Page Controller
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    focusNode.addListener(
      () {
        if (focusNode.hasFocus) {
          Navigator.push(
            context,
            PageTransition(
              child: PhoneAuthScreen(
                countryCode: countryCode,
                phoneIsoCode: phoneIsoCode,
                nonInternationalNumber: nonInternationalNumber,
              ),
              type: PageTransitionType.bottomToTop,
            ),
          );
        }
      },
    );
    super.initState();
  }

  // Indicator Container
  Widget _indicator(bool isActive) {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        height: isActive ? 12.0 : 8.0,
        width: isActive ? 12.0 : 8.0,
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
      ),
    );
  }

  // Build Page Indicator
  List _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 4; i++) {
      list.add(
        i == _currentPage ? _indicator(true) : _indicator(false),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xFF1C3857),
        body: AnnotatedRegion(
          value: SystemUiOverlayStyle.light,
          child: Container(
            height: MediaQuery.of(context).size.height - 225,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100.0,
                ),
                PageViewContainer(
                  pageController: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 30.0,
                    bottom: 40.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _buildPageIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          height: 225.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's get started! Enter your mobile number.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontFamily: "BalooPaaji",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: [
                    PhoneNumberTextField(
                      focusNode: focusNode,
                      phoneIsoCode: phoneIsoCode,
                      nonInternationalNumber: nonInternationalNumber,
                      onChanged: (phone) {},
                      onCountryChanged: (phone) {
                        setState(() {
                          countryCode = phone.countryCode;
                          phoneIsoCode = phone.countryISOCode;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
