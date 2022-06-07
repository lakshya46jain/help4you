// Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Dependency Imports
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
// File Imports
import 'package:help4you/services/auth.dart';
import 'package:help4you/screens/wrapper.dart';
import 'package:help4you/models/user_model.dart';
import 'package:help4you/services/onesignal_configuration.dart';

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
  RateMyApp rateMyApp = RateMyApp(
    minDays: 7,
    minLaunches: 10,
    remindDays: 7,
    remindLaunches: 10,
    googlePlayIdentifier: '',
    appStoreIdentifier: '',
  );

  // Navigator Key
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    // OneSignal Configuration
    configOneSignal();
    // Rate My App Feature
    rateMyApp.init().then(
      (_) {
        if (rateMyApp.shouldOpenDialog) {
          rateMyApp.showStarRateDialog(
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
                    await rateMyApp
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
            onDismissed: () => rateMyApp.callEvent(
              RateMyAppEventType.laterButtonPressed,
            ),
          );
        }
      },
    );
  }

  Future<void> configOneSignal() async {
    OneSignal.shared.setAppId(oneSignalAppID);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Help4YouUser>.value(
      initialData: Help4YouUser(),
      value: AuthService().user,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
