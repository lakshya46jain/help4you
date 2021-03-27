// Flutter Imports
import 'package:flutter/material.dart';
// Dependency Imports
import 'package:animations/animations.dart';
// File Imports
import 'package:help4you/screens/settings_screen/stream_builder.dart';
import 'package:help4you/screens/edit_profile_screen/edit_profile_screen.dart';

class EditProfileToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      clipBehavior: Clip.none,
      transitionDuration: Duration(milliseconds: 750),
      openElevation: 0.0,
      closedElevation: 0.0,
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      transitionType: ContainerTransitionType.fade,
      closedBuilder: (context, action) {
        return ProfileCardStreamBuilder();
      },
      openBuilder: (context, action) {
        return EditProfileScreen();
      },
    );
  }
}
