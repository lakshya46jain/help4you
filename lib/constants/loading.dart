// Flutter Imports
import "package:flutter/material.dart";
// Dependency Imports
import "package:flutter_spinkit/flutter_spinkit.dart";
// File Imports

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.75),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Container(
          width: 90.0,
          height: 90.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: const SpinKitDoubleBounce(
            color: Color(0xFF1C3857),
            size: 40.0,
          ),
        ),
      ),
    );
  }
}
