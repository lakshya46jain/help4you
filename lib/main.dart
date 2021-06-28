// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_core/firebase_core.dart';
// File Imports
import 'package:help4you/services/auth.dart';
import 'package:help4you/constants/loading.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/primary_screens/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  RateMyApp _rateMyApp = RateMyApp(
    minDays: 7,
    minLaunches: 10,
    remindDays: 7,
    remindLaunches: 10,
    googlePlayIdentifier: '',
    appStoreIdentifier: '',
  );

  @override
  void initState() {
    super.initState();
    // Rate My App Feature
    _rateMyApp.init().then(
      (_) {
        if (_rateMyApp.shouldOpenDialog) {
          _rateMyApp.showStarRateDialog(
            context,
            title: 'Rate Help4You',
            message:
                'Did you like your experience with Help4You? Then take a little bit of your time to leave a rating:',
            actionsBuilder: (context, stars) {
              return [
                TextButton(
                  child: Text('Ok'),
                  onPressed: () async {
                    HapticFeedback.lightImpact();
                    await _rateMyApp
                        .callEvent(RateMyAppEventType.rateButtonPressed);
                    Navigator.pop<RateMyAppDialogButton>(
                      context,
                      RateMyAppDialogButton.rate,
                    );
                  },
                ),
              ];
            },
            dialogStyle: DialogStyle(
              titleAlign: TextAlign.center,
              messageAlign: TextAlign.center,
              messagePadding: EdgeInsets.only(bottom: 20),
            ),
            starRatingOptions: StarRatingOptions(),
            onDismissed: () => _rateMyApp.callEvent(
              RateMyAppEventType.laterButtonPressed,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),

      // Firebase Builder
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: SvgPicture.asset(
                "assets/graphics/Help4You_Illustration_5.svg",
              ),
            ),
          );
        }

        // Show Application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<Help4YouUser>.value(
            initialData: Help4YouUser(),
            value: AuthService().user,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Wrapper(),
            ),
          );
        }

        // Initialization
        return Container(
          child: Center(
            child: DoubleBounceLoading(),
          ),
        );
      },
    );
  }
}
